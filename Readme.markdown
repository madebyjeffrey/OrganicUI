
Organic UI
==========

Primary Classes
---------------

### ORWindow	

#### Blackened Window with Disappearing Title Bar

ORWindow is my first attempt to recreate the title bar effect from Quicktime X. This was done for a game where I wanted the focus to be only on the game content, nothing else in the window.

Normally, the title bar is hidden, but it becomes visible when the mouse moves over it.

I would like to improve this, there are two main outstanding issues:

1.  The window buttons do not react to mouse movement.
2.  The title bar could look a lot better.

### ORNavigator

#### View to transition other full views in or out

ORNavigator is a view that manages a stack of controllers/views and will
transition between additions. If you push a controller on the stack, the old one will go to the left and the new one will come in from the right. Popping a controller is the reverse.

ORNavigator is in need of testing and is considered unstable right now.

Supporting Classes
------------------

### ORTitleBar		

The recreation of a title bar for ORWindow.

### NSColor+CGColor	

Adds a CGColor property (no patterns yet)

### NSBezierPath+JDAdditions

Adds corner construction methods

Classes not Finished
--------------------

### ORController		

An item that manages a view, used with ORNavigator. This might be better as a protocol on an NSViewController.

License
-------

A license hasn't been decided on, but I believe this code has the most utility when it is improved by those who use it for whatever purpose.

When you use it, a mention would be appreciated, although not required.

Website
-------

### Main site
[http://web.me.com/iaefai/OrganicUI/](http://web.me.com/iaefai/OrganicUI/)

### Source code
[https://github.com/iaefai/OrganicUI](https://github.com/iaefai/OrganicUI)

