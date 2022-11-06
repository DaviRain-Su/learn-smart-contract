# aptos simple coin

## Aptos command

新建move项目

```bash
aptos move init --name simple-coin
```

编译move项目

```bash
aptos move compile
```

测试move项目

```bash
aptos move test
```

部署move项目

```bash
aptos move publish --name-addresses simple_coin=default
```

## 如何发币

initialize

```bash
aptos move run --function-id 0x1::managed_coin::initialize --args string:"USDT" string:"USDT" u8:8 bool:true --type-args 0xa22db39c29d39404051540491440717beaf3c3edef3f06d30edff9bad68234a0::Coin::USDT
```

register

```bash
aptos move run --function-id 0x1::managed_coin::register --type-args 0xa22db39c29d39404051540491440717beaf3c3edef3f06d30edff9bad68234a0::Coin::USDT
```

mint

```bash
aptos move run --function-id 0x1::managed_coin::mint --args address:0xa22db39c29d39404051540491440717beaf3c3edef3f06d30edff9bad68234a0 u64:100000000 --type-args 0xa22db39c29d39404051540491440717beaf3c3edef3f06d30edff9bad68234a0::Coin::USDT
```

mint local net

```bash
aptos move run --function-id 0x1::managed_coin::mint --args address:0xa22db39c29d39404051540491440717beaf3c3edef3f06d30edff9bad68234a0 u64:100000000 --type-args 0xa22db39c29d39404051540491440717beaf3c3edef3f06d30edff9bad68234a0::Coin::USDT --private-key-file private-file --url http://127.0.0.0:8080
```
