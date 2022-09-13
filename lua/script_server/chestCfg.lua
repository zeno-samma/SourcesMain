


local SpawnCfg = {
    Zone1 = {
        MinPos = Vector3.new(-3, 1, -64),
        MaxPos = Vector3.new(14, 1, 41),
        MinCount = 50,
        MaxCount = 50,
        CfgName = "myplugin/Coins1"
    },
    Zone2 = {
        MinPos = Vector3.new(-2, 1, -69),
        MaxPos = Vector3.new(15, 1, 39),
        MinCount = 50,
        MaxCount = 50,
        CfgName = "myplugin/Coins2"
    },
    Zone3 = {
        MinPos = Vector3.new(-3, 1, -71),
        MaxPos = Vector3.new(24, 1, 41),
        MinCount = 50,
        MaxCount = 50,
        CfgName = "myplugin/Coins3"
    }
}


local Config = {
   --------------          ZONE1          --------------
    Zone1 = {
        Coins1 = {
            Model = "Coins1.actor",
            Hp = 6.5,
            Rate = 35,
            Received = {
                Gold = 5,      ---số trung bình, có thể tăng giảm trong khoảng 10%
                Diamond = 1
            }
        },
        Coins2 = {
            Model = "Coins2.actor",
            Hp = 12,
            Rate = 26,
            Received = {
                Gold = 7,      ---số trung bình, có thể tăng giảm trong khoảng 10%
                Diamond = 3
            }
        },
        Coins3 = {
            Model = "Coins3.actor",
            Hp = 25,
            Rate = 15,
            Received = {
            Gold = 25,
            Diamond = 5
            }
        },
        safeszone1 = {
            Model = "safeszone1.actor",
            Hp = 50,
            Rate = 10,
            Received = {
            Gold = 35,
            Diamond = 7
            }
        },
        safeslv2zone1 = {
            Model = "safeslv2zone1.actor",
            Hp = 100,
            Rate = 6,
            Received = {
            Gold = 66,
            Diamond = 11
            }
        },
        Diamondlv1 = {
            Model = "Diamondlv1.actor",
            Hp = 150,
            Rate = 5,
            Received = {
            Gold = 25,
            Diamond = 25
            }
        },
        Coin_gift_box = {
            Model = "Coin_gift_box.actor",
            Hp = 150,
            Rate = 2,
            Received = {
            Gold = 167,
            Diamond = 12
            }
        },
        ChestZone1 = {
            Model = "ChestZone1.actor",
            Hp = 250,
            Rate = 1,
            Received = {
            Gold = 200,
            Diamond = 25
            }
        }
    },
    --------------          ZONE2         --------------
    Zone2 = {
        Coinlv1_z2 = {
            Model = "Coinlv1_z2.actor",
            Hp = 200,
            Rate = 35,
            Received = {
            Gold = 202,      ---số trung bình, có thể tăng giảm trong khoảng 10%
            Diamond = 40
            }
        },
        Coins2_z2 = {
            Model = "Coinlv2_z2.actor",
            Hp = 400,
            Rate = 26,
            Received = {
            Gold = 257,
            Diamond = 58
            }
        },
        Coins3_z2 = {
            Model = "Coins3_z2.actor",
            Hp = 800,
            Rate = 15,
            Received = {
            Gold = 339,
            Diamond = 79
            }
        },
        Coins4_z2 = {
            Model = "Coins4_z2.actor",
            Hp = 1600,
            Rate = 10,
            Received = {
            Gold = 429,
            Diamond = 96
            }
        },
        Coins5_z2 = {
            Model = "Coins5_z2.actor",
            Hp = 3200,
            Rate = 6,
            Received = {
            Gold = 511,
            Diamond = 77
            }
        },
        Diamondlv2 = {
            Model = "Diamondlv2.actor",
            Hp = 3200,
            Rate = 5,
            Received = {
            Gold = 534,
            Diamond = 93
            }
        },
        giftboxz2 = {
            Model = "giftboxz2.actor",
            Hp = 3200,
            Rate = 2,
            Received = {
            Gold = 564,
            Diamond = 104
            }
        },
        ChestZone2 = {
            Model = "ChestZone2.actor",
            Hp = 6400,
            Rate = 1,
            Received = {
            Gold = 576,
            Diamond = 113
            }
        }
    },
    --------------          ZONE3         --------------
    Zone3 = {
        Coinlv1_z3 = {
            Model = "Coinlv1_z3.actor",
            Hp = 400,
            Rate = 35,
            Received = {
            Gold = 680,      ---số trung bình, có thể tăng giảm trong khoảng 10%
            Diamond = 130
            }
        },
        Coins2_z3 = {
            Model = "Coins2_z3.actor",
            Hp = 800,
            Rate = 26,
            Received = {
            Gold = 756,
            Diamond = 182
            }
        },
        Coins3_z3 = {
            Model = "Coins3_z3.actor",
            Hp = 1600,
            Rate = 15,
            Received = {
            Gold = 829,
            Diamond = 193
            }
        },
        Coins4_z3 = {
            Model = "Coins4_z3.actor",
            Hp = 3200,
            Rate = 10,
            Received = {
            Gold = 913,
            Diamond = 235
            }
        },
        Coins5_z3 = {
            Model = "Coins5_z3.actor",
            Hp = 6400,
            Rate = 6,
            Received = {
            Gold = 965,
            Diamond = 269
            }
        },
        Diamondlv3 = {
            Model = "Diamondlv3.actor",
            Hp = 12800,
            Rate = 5,
            Received = {
            Gold = 990,
            Diamond = 279
            }
        },
        giftboxz3 = {
            Model = "giftboxz3.actor",
            Hp = 12800,
            Rate = 2,
            Received = {
            Gold = 1006,
            Diamond = 306
            }
        },
        ChestZone3 = {
            Model = "ChestZone3.actor",
            Hp = 12800,
            Rate = 1,
            Received = {
            Gold = 1064,
            Diamond = 328
            }
        }
    }
}

local function _Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

return {
    SpawnConfig = SpawnCfg,
    chestConfig = Config,
    Split = _Split
}