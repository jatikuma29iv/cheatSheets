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
