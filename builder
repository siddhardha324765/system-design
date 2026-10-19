# Builder Design Pattern in Java

## 1. What is the Builder Pattern?

The Builder Pattern is a creational design pattern used to construct complex objects step by step.

It separates the process of configuring an object from the creation of the final object.

It is especially useful when a class has many optional parameters or different possible configurations.

## 2. Why was it introduced?

Imagine a food-ordering application where customers can customize their burgers.

One customer wants cheese and lettuce, another wants extra sauce, and another wants only a basic burger.

Using a constructor with many parameters can make object creation confusing.

For example:

```java
Burger burger = new Burger(
    "Sesame", true, false, true, false, true
);
```

It is difficult to remember what each boolean value represents.

We could create multiple overloaded constructors, but managing many combinations would become complicated.

Another approach is to create an empty object and set its fields afterward. However, this may allow incomplete or invalid objects to be used.

**The Builder Pattern solves this problem by allowing us to configure an object step by step and create the final object when we call `build()`.**

## 3. Real-World Example

Consider a burger with the following options:

- Bun type
- Cheese
- Lettuce
- Tomato
- Extra sauce

Different customers can select different combinations.

The Builder Pattern allows us to create customized burgers without writing a separate constructor for every combination.

Example:

```java
Burger burger = new Burger.Builder("Sesame")
        .cheese(true)
        .lettuce(true)
        .tomato(false)
        .build();
```

## 4. Main Components

### Burger (Product)

Represents the final object being created.

It contains the burger's attributes and methods for using the completed object.

### Burger.Builder (Builder)

A static nested class responsible for collecting configuration values.

It provides methods to set optional attributes and a `build()` method to create the final Burger object.

### Main (Client)

Uses the builder to configure and create a burger.

## 5. Working Process

1. Create a Builder object.
2. Set the required attributes.
3. Configure optional attributes using builder methods.
4. Call `build()`.
5. The builder creates the final Burger object.
6. Use the completed object.

## 6. Why Is the Builder Class Static?

The Builder class is declared as a static nested class inside Burger.

This allows us to create a builder without creating a Burger object first.

```java
Burger.Builder builder =
        new Burger.Builder("Sesame");
```

The builder is separate from the final Burger object.

## 7. What Does `build()` Do?

The `build()` method creates and returns the final Burger object using the values stored in the builder.

```java
public Burger build() {
    return new Burger(this);
}
```

Here, `this` refers to the current Builder object.

The Burger constructor copies the builder's values into the new Burger object.


## 8. Builder vs Constructor

| Constructor | Builder |
|---|---|
| Creates an object directly. | Configures an object before creating it. |
| Can become difficult to read with many parameters. | Uses descriptive method calls. |
| Supports required parameters naturally. | Can combine required and optional parameters. |
| Best for simple objects. | Useful for complex or highly configurable objects. |

## 9. Important Note

The Builder Pattern is a creational design pattern. It is useful when object construction involves many optional settings or multiple steps.

It was documented as one of the Gang of Four design patterns in the book *Design Patterns: Elements of Reusable Object-Oriented Software* (1994).

**Summary:** Create Builder → Configure attributes → Call `build()` → Receive the final object.

----------------------------------------------------        Code -------------------------------------------------------------------------

public class Burger {

    private final String bun;
    private final boolean cheese;
    private final boolean lettuce;
    private final boolean tomato;
    private final boolean extraSauce;

    // Private constructor
    private Burger(Builder builder) {
        this.bun = builder.bun;
        this.cheese = builder.cheese;
        this.lettuce = builder.lettuce;
        this.tomato = builder.tomato;
        this.extraSauce = builder.extraSauce;
    }

    public void display() {
        System.out.println("Bun: " + bun);
        System.out.println("Cheese: " + cheese);
        System.out.println("Lettuce: " + lettuce);
        System.out.println("Tomato: " + tomato);
        System.out.println("Extra Sauce: " + extraSauce);
    }

    // Static nested Builder class
    public static class Builder {

        private final String bun;
        private boolean cheese;
        private boolean lettuce;
        private boolean tomato;
        private boolean extraSauce;

        public Builder(String bun) {
            if (bun == null || bun.isBlank()) {
                throw new IllegalArgumentException(
                        "Bun is required");
            }

            this.bun = bun;
        }

        public Builder cheese(boolean value) {
            this.cheese = value;
            return this;
        }

        public Builder lettuce(boolean value) {
            this.lettuce = value;
            return this;
        }

        public Builder tomato(boolean value) {
            this.tomato = value;
            return this;
        }

        public Builder extraSauce(boolean value) {
            this.extraSauce = value;
            return this;
        }

        public Burger build() {
            return new Burger(this);
        }
    }
}
public class Main {

    public static void main(String[] args) {

        Burger burger1 = new Burger.Builder("Sesame")
                .cheese(true)
                .lettuce(true)
                .tomato(false)
                .extraSauce(true)
                .build();

        System.out.println("Burger 1:");
        burger1.display();

        System.out.println();

        Burger burger2 = new Burger.Builder("Whole Wheat")
                .cheese(false)
                .lettuce(true)
                .build();

        System.out.println("Burger 2:");
        burger2.display();
    }
}
