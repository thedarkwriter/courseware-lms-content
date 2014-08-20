# Inheritance
Classes can be derived from other classes using the `inherits` keyword. This allows you to make special-case classes that extend the functionality of a more general “base” class.

**Note**: Puppet 3 does not support using parameterized classes for inheritable base classes. The base class **must** have no parameters.

At the end of this course you will be able to:

* define inheritance.
* identify appropriate use cases for inheritance.
* list best practices for inheritance.

## Video ##
[Link to Video](http://linktovideo)

## Exercises ##
Assuming you have a working Puppet installation:

1. Execute, etc.
2. Execute, etc.
3. Execute, etc.

## Quiz ##
1. The Puppet keyword used to extend the functionality of a class is called:
a. extend b. declare c. **inherits** d. include
2. True or False. When the derived (inherited) class is declared, its base class is automatically declared first. (True)
3. You have a base class called `ssh` that you need to extend. The new class will be called `paranoid`. Which of the following is the correct syntax for the first line of the `paranoid` class?
a. `class paranoid extends ssh {`
b. `class paranoid inherits ssh {`
c. `class ssh declares paranoid {`
d. `class ssh::paranoid inherits ssh {`
b or d
4. True or False. Inheritance should be used within a module to reduce repitition. (True)
5. True or False. It is considered a best practice to use inheritance across modules. (False)

## Resources ##
* [Inheritance - Docs](http://docs.puppetlabs.com/puppet/3/reference/lang_classes.html#inheritance)
* [Inheritance - Style](http://docs.puppetlabs.com/guides/style_guide.html#class-inheritance)