# ERC20 TOKEN

在模块0xCAFE::IMCoin中实现类似 ERC20 的token功能，需要满足以下要求：

1. 完成 issue 函数，其功能是在地址 issuer 下发布一个资源 Coin。
- 发行者（issuer） 必须等于常量 ISSUER，否则以状态码 1001 中止
- 如果 发行者（issuer） 已经有 Coin 资源了，则以状态码 1002 中止
- Coin 资源的 发行量（supply） 和 持有者数量（holders） 的初始值都为 0

2. 完成函数 supply, 返回 ISSUER 地址下的资源 Coin 的 发行量（supply） 值
- 如果 ISSUER 没有资源 Coin, 以状态码 1003 中止

3. 完成函数 register, 其功能是在 account 的地址下发布资源 Balance
- 如果 ISSUER 没有资源 Coin, 以状态码 1003 中止
- 如果 account 已经有 Balance 了, 以状态码 2001 中止
- ISSUER 下的资源 Coin 的 持有者数量（holders） 加 1
- Balance 的初始 value 为 0

4. 完成函数 deposit, 其功能是给 receiver 增加数量为 amount 的余额
- 发行者（issuer） 必须等于常量 ISSUER，否则以状态码 1001 中止
- 增加数量为 amount 的 发行量（supply），并且增加后的 发行量（supply） 不能超过 MAX_SUPPLY，否则以状态码 1004 中止

5. 完成函数 balance, 其功能是返回 addr 地址下的 Balance 的 value
- 如果 addr 没有 Balance , 以状态码 2002 中止

6. 完成函数 transfer, 其功能是从 发送者（sender） 转移数量为 amount 的余额到 接收者（receiver）
- 发送者不能与接收者相同，否则以状态码 2003 中止
- amount 不能超过发送者的余额，否则以状态码 2004 中止

Execute: test_issue(0x42)
Test passed: abort 1001
Execute: test_register(0x80)
Test passed: abort 1003
Execute: test_deposit(0xCAFE, 0X42, 13)
Test passed: abort 1003
Execute: test_issue(0xCAFE)
Execute: supply_should_equals(0)
Execute: holders_should_equals(0)
Execute: test_issue(0xCAFE)
Test passed: abort 1002
Execute: balance_should_equals(0x80, 0)
Test passed: abort 2002
Execute: test_register(0x80)
Execute: test_register(0x80)
Test passed: abort 2001
Execute: holders_should_equals(1)
Execute: balance_should_equals(0x80, 0)
Execute: test_deposit(0x80, 0x80, 13)
Test passed: abort 1001
Execute: test_deposit(0xCAFE, 0x42, 13)
Test passed: abort 2002
Execute: test_deposit(0xCAFE, 0x80, 1025)
Test passed: abort 1004
Execute: test_deposit(0xCAFE, 0x80, 657)
Execute: balance_should_equals(0x80, 657)
Execute: test_transfer(0x80, 0x42, 57)
Test passed: abort 2002
Execute: test_transfer(0x80, 0x80, 57)
Test passed: abort 2003
Execute: test_register(0x42)
Execute: test_transfer(0x80, 0x42, 658)
Test passed: abort 2004
Execute: test_transfer(0x80, 0x42, 57)
Execute: balance_should_equals(0x80, 600)
Execute: balance_should_equals(0x42, 57)
Test passed.