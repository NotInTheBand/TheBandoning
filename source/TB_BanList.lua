-- All IP's that attempt to crack our scripts or products TheBandoning Whitelist supports will be made public within this database.
-- If you purchase a product from TheBandoning and were added to this list, you have voided your warranty and earned a spot on our global ban list which will not allow you to run our product. The product will not be refunded at the request.

local banList = {
    user = {
        "IwantTOINSIDEyou",
        "Polar_FruitV2",
    },
    userId = {
        2252321929,
    },
    hwid = {
        syn = {
            "700056733d54cc7ea762ef26ef30050d5858b0calebec025e77la07818a069b8fbaa4e4dc9602ed1197c86931d72ba68fda79fa59cb5adf68d68cc29cd55003e",
            "ed9f0d17cf05fa782661a92620aff28a6fb63c763b75ef119026e6c29b40ea36ccab9d4e9c9dad9a24f510d15468b27149bce56fcd1734fea17bc4d8535ce8de",
        },
    },
    ip = {
        "8.38.147.26",
        "115.87.120.104",
    },
}

local function IdentifyExecutor()
    if SentinelBuy then
        return "Sentinel";
    elseif LUAPROTECT ~= nil then
        return "SirHurt";
    elseif AES ~= nil then
        return "ProtoSmasher";
    elseif syn_crypt_encrypt ~= nil then
        return "Synapse";
    else
        return "Krnl";
    end
end

function ifBanThenCrash()
    if IdentifyExecutor() == "Synapse" then
        local matchFound
        for i,v in pairs(banList) do
            
        end
    end
end