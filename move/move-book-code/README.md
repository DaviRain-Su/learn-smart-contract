# Move book code example


## 模块和脚本

Move 有两种不同类型的程序：模块（Module）和脚本（Script）。模块是定义结构类型以及对这些类型进行操作的函数的库。结构类型定义了 Move 的全局存储的模式，模块函数定义了更新存储的规则。模块本身也存储在全局存储中。脚本是可执行文件的入口点，类似于传统语言中的主函数 main。脚本通常调用已发布模块的函数来更新全局存储。脚本是临时代码片段，不会发布在全局存储中。

一个 Move 源文件（或编译单元）可能包含多个模块和脚本。然而，发布模块或执行脚本都是独立的虚拟机（VM）操作。

const 关键字定义了可以在模块函数中使用的私有常量

从根本上说，模块是类型（type）和函数（function）的集合。use 关键字用来从其他模块导入类型。

## move 教程

Move 结构体可以通过给类型设定不同的能力abilities让类型下支持对应的行为. 有四种能力:

- copy: 允许此类型的值被复制
- drop: 允许此类型的值被弹出/丢弃
- store: 允许此类型的值存在于全局存储的某个结构体中
- key: 允许此类型作为全局存储中的键(具有 key 能力的类型才能保存到全局存储中)

所以 BasicCoin 模块下的 Coin 结构体可以用作全局存储(global storage)的键(key)， 因为它又不具备其他能力，它不能 被拷贝，不能被丢弃, 也不能作为非key来保存在(全局)存储里. 你无法复制 Coin，也不会意外弄丢它.

函数Functions默认是私有的(private), 也可以声明为 public public(friend), public(script). 最后一个声明(指 public(script))的函数可以被事务脚本调用。public(script) 函数也可以被其他 public(script) 函数调用。(注意：在最新版本的 Move中，public(script) 已经被废弃，被public entry 取代，下同，译者注)

moove_to 是五种不同的全局存储操作之一
