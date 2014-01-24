Buffers and hidden buffers
==========================

Demonstration
-------------

Here I have a directory with files named A, B, C, D and E. I'm going to launch
Vim in this directory with a wildcard as an argument. This tells Vim to load
each file in this directory ending in .txt into a buffer. To begin with, all you 
can see is the first of these files, but if I run the command:

    :ls

then you can see that each of the files has been loaded into a buffer. I can
easily scroll through the buffers by running:

    :bn[ext]

to view the next buffer, or:

    :bp[revious]

to view the previous buffer. Note that previous and next commands do cycle
between the first and last items in the buffer list.

Anytime that you run `:ls`, you get a list of the buffers. These include a few
annotations:

* 'a' marks an active buffer, meaning that it is currently loaded in a window
* '#' (the hash sign) marks the alternate buffer

You can quickly jump between the active buffer and the alternate buffer using
the command: `ctrl-^`. Pressing it again takes you back to where you were
before. You can think of this as being a bit like the command-tab behaviour in
OS X (or alt-tab in linux and windows), which switches focus between the
currently active window, and the application you used most recently.

Now lets try making a change to file A, without saving it. If I run `:ls`
again, you should see a new symbol:

* \+ (the plus sign) indicates that a buffer has been modified, therefore its
contents differ from the corresponding file

Having made this change, but not saved it, let's now try and switch to another
buffer with the `:bn` command. This raises an error:

   E37: No write since last change (add ! to override)

At this point, I could do a couple of things:

* save the file, and reissue the command to move on to the next buffer
* or follow the advice in the prompt, and run the command with a trailing
exclamation mark

Let's try running `:bn!` (b-n-bang), as advised. OK, this brings us to the next buffer,
as expected. So lets see what happens now when I run `:ls`

* File A is still marked with a + (plus sign), indicating that the buffer has
been modified
* additionally, the file is marked with an 'h', which stands for hidden

A buffer is marked as 'hidden' if it has unsaved changes, and it is not
currently loaded in a window. 

##Consequences of having hidden buffers

If you try and quit Vim while there are hidden buffers, an error will be 
raised:

   E162: No write since last change for buffer "a.txt:

When you dismiss the error message, you'll find that the first hidden buffer
has been loaded into your current window. This gives you the opportunity
to either:

* save the changes to a file (`:w`)
* restore the original file (`:e!`)
* or forcibly remove the buffer from the buffer list (`:bd!`), discarding any
changes
* you can also force Vim to quit, discarding changes to all modified buffers
(`:q!`)

By default, Vim makes it difficult for you to create a hidden buffer, but as 
long as you know how to deal with them when quitting Vim, there's nothing
wrong with creating them. To make Vim use hidden buffers more 
liberally, I include the following line in my .vimrc:

   set hidden

With this setting applied, when I try to navigate away from a buffer with
unsaved changes, Vim will automatically hide it. Now, I can run the `:bn`
command, and it will switch to the next buffer without raising an error 
message.
