# dot Net Programing

## Unit test cases

### Method Run order

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


<<<<<<< HEAD

### Syntax for UnitTest Case

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

## After that we should add reference 

Go to solution explorer (On right most window)

1.click on the test project that was created

2.Below the test project there is reference 

3.Right click on it -->add reference 

4.New window opens Put check mark to class Library project and click ok 

### How to Run Test Cases

1.In MS VisualStudio toolbar -->Click on test-->window-->Test Expolrer

2.A new Window Test explorer is opened on (left most side)

3.Click Run or Run all to (Run the test cases)




#### Testing data for Valid scenarios is Positive testing.
#### Testing data for InValid scenarios is Negative testing.


 

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
=======
## C #

### Adding package using `nuget`

x
x


### Dictionary

* How to instantiabe new Dictionary

 Dictionary <TKey,TValue> contains a collection of key/value pairs.Its Add method takes two parameters, one for the key and one for the value

```csharp

// sample here

	**Syntax**
	
class classname
{
	public string variable {get; set;}
}

class call{
		 Dictionary<int, classname> names = new Dictionary<int,Name>()
			{
					{01,classname{variable="value"}},
					
				};
}	

```

* How to extract value

```csharp
// say dictionary object is Obj

	// to get object from sources
	var o = Obj[ str ];

```


### List

* How to instantiabe new List

A List is an ordered Collection.Lists may contain duplicate elements. 
In addition to the operations inherited from Collection, the List interface include

	*Search
	*Iteration
	*Positional access

```csharp

// sample here

ArrayList<String> list = new ArrayList<String>() {{
    add("item1");
    add("item2");
    add("item3");
}}

```

* How to extract value

```csharp
// say dictionary object is Obj

	// to get object from sources
	var o = Obj[ i ];

```


### NewtonSoft Json

* How to instantiabe new JObject
Object initializers let you assign values to any accessible fields or properties of an object at creation time without having to invoke a constructor followed by lines of assignment statements.

```csharp

// sample here
 
		class Name
{
    // Auto-implemented properties.
    public int fName { get; set; }
    public string lName { get; set; }
}


		Name name = new name {fName = "abc", lName = "xyz" };

```
* How to instantiabe new JArray

```csharp

// sample here
using Newtonsoft.Json.Linq.JArray

	 var a = JArray.Parse(json);

```

* How to extract value

```csharp
// say dictionary object is Obj

	 var s = i["source"].ToString();

		
```


* How to parse string

```csharp
// say dictionary object is Obj

	string phrase = "The quick brown.";
	string[] words = phrase.Split(' ');

```

### Looping


#### Foreach

```csharp

// sample here
 foreach (var i in a)
            {
                // extract the source name
               

                // check if bucket of above sourcename exist
                if ()
                {
                    // the bucket exists
                    // get existing bucket
             
                     
                }
                else
                {
                    // the bucket do not exist
                    // create bucket
                    
                     result.Sources.Add(s, b);
                   
                }


```
>>>>>>> c895460dbe77ae3fcd389fb05789a5d66d276f97
