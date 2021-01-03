# Unit test cases

## Method Run order

The order that methods will be run is:

1. Methods marked with the `AssemblyInitializeAttribute`.

1. Methods marked with the `ClassInitializeAttribute`.

1. Methods marked with the `TestInitializeAttribute`.

1. Methods marked with the `TestMethodAttribute`.

```csharp

[Test] 
public void pushing_an_item_onto_an_empty_stack_increments_count() 
{ 
    // Arrange 
    var stack = new Stack<bool>();

    // Act 
    stack.Push(false);

    // Assert 
    Assert.That(stack.Count, Is.EqualTo(1));    
}

```

## Syntax for UnitTest Case

```csharp
using System;

using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
        }
    }
}
```


## How to Prepare Unit Test cases in CSharp

### Write a basic calculator code

Open MS VisualStudio 

Create A New Class Library project

Write a simple calculator code


```csharp
using system;

namespace ClassLibrary1
{
    public class Calculator
    {
        public int Multiply(int x, int y)
        {
            return x * y;
        }
    }
}
```


### Writing Test cases for the above Calculator code

Go to solution explorer (On right most window)

1.right click on the Project

2.Under that add -->New project

3.Under New project -->New test Project  

### After that we should add reference 

Go to solution explorer (On right most window)

1.click on the test project that was created

2.Below the test project there is reference 

3.Right click on it -->add reference 

4.New window opens Put check mark to class Library project and click ok 

## How to Run Test Cases

1.In MS VisualStudio toolbar -->Click on test-->window-->Test Expolrer

2.A new Window Test explorer is opened on (left most side)

3.Click Run or Run all to (Run the test cases)

### Testing data for Valid scenarios is Positive testing.

### Testing data for InValid scenarios is Negative testing.

```csharp
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Test_Proj
{
    [TestClass]
    public class CalculatorTest
    {
        [TestMethod]
        public void TheMethodShouldReturn-Ve10()
        {
            var calc = new Calculator();

            var result = calc.Multiply(2, 5);

            Assert.AreEqual(result, -10);
        }  ***//This test fails beacuse the value returing is -ve10***
		
    }
}
```

### Test case for valid scenario 

```csharp
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Test_Proj
{
    [TestClass]
    public class CalculatorTest
    {
        [TestMethod]
        public void TheMethodShouldReturn+Ve10()
        {
            var calc = new Calculator();

            var result = calc.Multiply(2, 5);

            Assert.AreEqual(result, 10);
        }  ***//This test passes beacuse the value returing is +ve10*** 
    }
}
```

```csharp
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;


namespace Test_Proj
{
    [TestClass]
    public class CalculatorTest
    {
        [TestMethod]
        public void TheMethodShouldReturn10()
        {
            var calc = new Calculator();

            var result = calc.Multiply(20, 5);

            Assert.AreEqual(result, -100);
        }  ***//This test fails beacuse the value returing is +ve100*** 
    }
}
```

```csharp
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Test_Proj
{
    [TestClass]
    public class CalculatorTest
    {
        [TestMethod]
        public void TheMethodShouldReturn10()
        {
            var calc = new Calculator();

            var result = calc.Multiply(20, -5);

            Assert.AreEqual(result, -100);
        }  ***//This test passes beacuse the value returing is -ve100*** 
    }
}
```
