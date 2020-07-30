# Python
Introduction on Python Programming

* Desktop Application tkinter - not web page
* Web Application : flask


 * _Variable assignment_ Here we create a variable called x and assign it the value of 0 using =, which is called the assignment operator
            
            x = 0
 *  _Function calls_ print() is a Python function that displays the value passed to it on the screen. We call functions by putting parentheses after their name, and putting the inputs (or arguments) to the function in those parentheses
   
             print(x)
*   The colon (:) at the end of the if line indicates that a new "code block" is starting. Subsequent lines which are indented are part of that code block. Some other languages use {curly braces} to mark the beginning and end of code blocks. Python's use of meaningful whitespace can be surprising to programmers who are accustomed to other languages, but in practice it can lead to more consistent and readable code than languages that do not enforce indentation of code blocks
   
             x=0
            print(x)

            x = x + 4

            if x > 0:
               print("Number is greater than 0")
    
            z = "Hello " * x
            print(z)  
                
Numbers and arithmetic in python

* type() is the second built-in function we've seen (after print()), and it's another good one to remember. It's very useful to be able to ask Python "what kind of thing is this?"

* A natural thing to want to do with numbers is perform arithmetic. We've seen the + operator for addition, and the * operator for multiplication (of a sort). Python also has us covered for the rest of the basic buttons on your calculator:

      Operator	      Name	               Description
      a + b	         Addition	            Sum of a and b
      a - b	         Subtraction	         Difference of a and b
      a * b	         Multiplication	      Product of a and b
      a / b	         True division	      Quotient of a and b
      a // b	      Floor division	      Quotient of a and b, removing fractional parts
      a % b	         Modulus	            Integer remainder after division of a by b
      a ** b	      Exponentiation	      a raised to the power of b
      -a	            Negation	            The negative of a

Builtin Functions for working with numbers

* min() and max() retur the minimum and maximum of their arguments

      print(min(3,5,7,1))
      print(max(8,9,2,4))
      
* abs() returns absolute value of it argument 

      print(abs(85.245))

The help() function is possibly the most important Python function you can learn. If you can remember how to use help(), you hold the key to understanding most other function

             help(round)
* help() displays two things:
   - the header of that function round(number[, ndigits]). In this case, this tells us that round() takes an argument we can describe as number. Additionally, we can optionally      give a separate argument which could be described as ndigits.
   - A brief English description of what the function does
   
Defining Functions
 
            def least_difference(a, b, c):
                diff1 = abs(a - b)
                diff2 = abs(b - c)
                diff3 = abs(a - c)
                return min(diff1, diff2, diff3)   
                
 * This creates a function called least_difference, which takes three arguments, a, b, and c.

 * Functions start with a header introduced by the def keyword. The indented block of code following the : is run when the function is called.

 * return is another keyword uniquely associated with functions. When Python encounters a return statement, it exits the function immediately, and passes the value on the right hand side to the calling context.

 * Without a return statement, least_difference is completely pointless
 
 Default Arguments 
 
            print(1,2,3)
            
            print(1,2,3, sep = "<")

Functions Appiled to Functions

Here's something that's powerful, though it can feel very abstract at first. You can supply functions as arguments to other functions. Some example may make this clearer

            def mult_by_five(x):
                return 5 * x

            def call(fn, arg):
                 """Call fn on arg"""
                 return fn(arg)

            def squared_call(fn, arg):
                """Call fn on the result of calling fn on arg"""
                return fn(fn(arg))

            print(
                 call(mult_by_five, 1),
                 squared_call(mult_by_five, 1), 
                 sep='\n', # '\n' is the newline character - it starts a new line
                    )

Booleans
* Python has a type of variable called bool. It has two possible values: True and False
 * Comparison Operators
 
            Operation	            Description		

            a == b	            a equal to b		
            a != b	            a not equal to b
            a < b	            a less than b		
            a > b	            a greater than b
            a <= b	            a less than or equal to b		
            a >= b	            a greater than or equal to b


                       3.0 == 3 
                       # True
                       
                       '3' == 3
                       #False
                       
* Remember to use == instead of = when making comparisons
* Booleans are most useful when combined with conditional statements, using the keywords if, elif, and else

            if x == 0:
                print(x, "is zero")
            elif x > 0:
                print(x, "is positive")
            elif x < 0:
                print(x, "is negative")
            else:
                print(x, "is unlike anything I've ever seen...")

* Define a function called sign which takes a numerical argument and returns -1 if it's negative, 1 if it's positive, and 0 if it's 0  

            def sign(x):
                if x > 0:
                    return 1
                elif x < 0:
                    return -1
                else:
                    return 0
## Lists
* Lists in Python represent ordered sequences of values. Here is an example of how to create them:

            primes = [2, 3, 5, 7]
            
            We can put other types of things in lists:
            planets = ['Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune']
            
            We can even make a list of lists:
            hands = [
                        ['J', 'Q', 'K'],
                        ['2', '2', '2'],
                        ['6', 'A', 'K'], # (Comma after the last element is optional)
                     ]
                     
            #I could also have written this on one line, but it can get hard to read
            hands = [['J', 'Q', 'K'], ['2', '2', '2'], ['6', 'A', 'K']]
            
            A list can contain a mix of different types of variables:
            my_favourite_things = [32, 'raindrops on roses', help]
   
   ## Indexing
   * We can access individual list elements with square brackets.
   * Elements at the end of the list can be accessed with negative numbers, starting from -1:
   
            list[0]
            list[1]
            list[-1]
            
    ## Slicing
    
            planets[0:3]
            planets[0:3] is our way of asking for the elements of planets starting from index 0 and continuing up to but not including index 3
            
            The starting and ending indices are both optional. If I leave out the start index, it's assumed to be 0. So I could rewrite the expression above as:
            planets[:3]
            
            If I leave out the end index, it's assumed to be the length of the list.
            planets[3:]
            
            We can also use negative indices when slicing:
            
            # All the planets except the first and last
            planets[1:-1]
            
            # The last 3 planets
            planets[-3:]
### Changing lists
* Lists are __"mutable"__, meaning they can be modified "in place".
 - One way to modify a list is to assign to an index or slice expression.
                      
                      planets[3] = 'New assigned value'
### List functions
* Python has several useful functions for working with lists

             How many planets are there?
             len(planets)
             output 8
             
             The planets sorted in alphabetical order
             sorted(planets)
             
             sum - does what you might expect:
             primes = [2, 3, 5, 7]
             sum(primes)
             17
             
             max(primes)
             7
    ### Interlude: objects
    numbers in Python carry around an associated variable called imag representing their imaginary part
    
            x = 12
            # x is a real number, so its imaginary part is 0.
            print(x.imag)
            0
            
            # Here's how to make a complex number, in case you've ever been curious:
            c = 12 + 3j
            print(c.imag)
            3.0
### List Methods

            list.append -  modifies a list by adding an item to the end:
            planets.append('Pluto')
            
            list.pop removes and returns the last element of a list:
  * Searching lists
  
            Where does Earth fall in the order of planets? We can get its index using the list.index method
            planets.index('Earth')
            2
            It comes third (i.e. at index 2 - 0 indexing!)
 * We can use the in operator to determine whether a list contains a particular value:
 
            # Is Earth a planet?
            "Earth" in planets
            TRUE
            
            # Is Calbefraques a planet?
            "Calbefraques" in planets
            FALSE
   ### Tuples
* Tuples are almost exactly the same as lists. They differ in just two ways
1: The syntax for creating them uses parentheses instead of square brackets
2: They cannot be modified (they are immutable).
            
            1.          t = (1, 2, 3)
            2.          t[0] = 100 # Error
* Tuples are often used for functions that have __multiple return values__
- the as_integer_ratio() method of float objects returns a numerator and a denominator in the form of a tuple:

            x = 0.125
            x.as_integer_ratio()
            (1,8)
   
   _These multiple return values can be individually assigned as follows
   
            numerator, denominator = x.as_integer_ratio()
            print(numerator / denominator)
            0.125
            
            

                
