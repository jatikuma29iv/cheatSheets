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
