"use strict";

const { Contract } = require("fabric-contract-api");

class FabCar extends Contract {
    async initLedger(ctx) {
        const res = await ctx.stub.putState("test", "hello world");
        console.log("=====Ledger Initialized=====");
    }
    async readData(ctx, key) {
        const res = await ctx.stub.getState(key);
        if (res) {
            return res;
        }
    }
    async recordAluminumCanManufacture(
        ctx,
        manufacturer,
        canId,
        timeStamp,
        placeOfMaufacture,
        BatchNo,
        contents,
        objectType
    ) {
        const can = {
            manufacturer: manufacturer,
            id: canId,
            timeStamp: timeStamp,
            status: "MANUFACTURED",
            circular: false,
            placeOfMaufacture: placeOfMaufacture,
            BatchNo: BatchNo,
            contents: contents,
            objectType: objectType,
            lifeCycleCount: 0,
            recycledBatch: null,
        };
        await ctx.stub.putState(canId, Buffer.from(JSON.stringify(can)));
        return `Data written was successful`;
    }
    async recordAluminiumCanSale(ctx, retrailer, canId, timeStamp) {
        const canBytes = await ctx.stub.getState(canId);
        if (!canBytes || canBytes.length == 0) {
            throw new Error(`Can with ID ${canId} does not exists`);
        }
        const can = JSON.parse(canBytes.toString());
        if (can.status !== "MANUFACTURED") {
            throw new Error(
                `Can with id ${canId} has already been sold or recycled`
            );
        }
        can.retrailer = retrailer;
        can.timeStamp = timeStamp;
        can.status = "SOLD";
        await ctx.stub.putState(canId, Buffer.from(JSON.stringify(can)));
        return `Data written was successful`;
    }
    async recordAluminumCanUsage(ctx, userId, canId, timeStamp, batchNo) {
        const canBytes = await ctx.stub.getState(canId);
        if (!canBytes || canBytes.length == 0) {
            throw new Error(`Can with ${canId} does not exists`);
        }
        const can = JSON.parse(canBytes.toString());
        if (can.status !== "SOLD") {
            throw new Error(
                `Can with ${canId} has not been sold or has already been recycled`
            );
        }
        can.userId = userId;
        can.timeStamp = timeStamp;
        can.status = "USED";
        can.batchNo = batchNo;
        await ctx.stub.putState(canId, Buffer.from(JSON.stringify(can)));
        return `Data written was successful`;
    }
    async recordAluminiumCanSegregate(ctx, segregator, canId, timeStamp) {
        const canBytes = await ctx.stub.getState(canId);
        if (!canBytes || canBytes.length == 0) {
            throw new Error(`Can with ${canId} does not exists`);
        }
        const can = JSON.parse(canBytes.toString());

        if (can.status !== "USED" && !can.circular) {
            throw new Error(
                `Can with ID ${canId} has not been used or already been recycled`
            );
        }
        can.segregator = segregator;
        can.timeStamp = timeStamp;
        can.status = "SEGREGATED";
        await ctx.stub.putState(canId, Buffer.from(JSON.stringify(can)));
        return `Data written was successful`;
    }
    async recordAluminiumCanRecycle(
        ctx,
        canId,
        recycler,
        timeStamp,
        chemicals
    ) {
        const canBytes = await ctx.stub.getState(canId);
        if (!canBytes || canBytes.length == 0) {
            throw new Error(`Can with ${canId} does not exists`);
        }
        const can = JSON.parse(canBytes.toString());

        if (can.status !== "SEGREGATED" && !can.circular) {
            throw new Error(
                `Can with ${canId} has not been used or already been Recycled`
            );
        }
        can.timeStamp = timeStamp;
        can.status = "RECYCLED";
        can.chemicals = chemicals;
        can.circular = true;
        can.recycler = recycler;
        await ctx.stub.putState(canId, Buffer.from(JSON.stringify(can)));
        const recycledCan = {
            manufacturer: can.manufacturer,
            id: can.id,
            timeStamp: timeStamp,
            status: "MANUFACTURED",
            circular: true,
            objectType: `${can.objectType}-recycled`,
            lifeCycleCount: parseInt(can.lifeCycleCount) + 1,
            recycledBatch: can.BatchNo,
        };
        await ctx.stub.putState(
            `${canId}-recycled`,
            Buffer.from(JSON.stringify(recycledCan))
        );
        return `Data written was successful`;
    }
    async getAluminiumCanHistory(ctx, canId) {
        const iterator = await ctx.stub.getHistoryForKey(canId);
        const results = [];
        while (true) {
            const res = await iterator.next();
            if (res.value && res.value.value.toString()) {
                const obj = JSON.parse(res.value.value.toString("utf-8"));
                results.push(obj);
            }
            if (res.done) {
                await iterator.close();
                return results;
            }
        }
    }

    async queryAllData(ctx) {
        const startKey = "";
        const endKey = "";
        const allResults = [];
        for await (const { key, value } of ctx.stub.getStateByRange(
            startKey,
            endKey
        )) {
            const strValue = Buffer.from(value).toString("utf8");
            let record;
            try {
                record = JSON.parse(strValue);
            } catch (err) {
                console.log(err);
                record = strValue;
            }
            allResults.push({ Key: key, Record: record });
        }
        console.info(allResults);
        return JSON.stringify(allResults);
    }
}

module.exports = FabCar;
