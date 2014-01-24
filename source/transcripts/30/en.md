    1955, November 5th

    1955, November 12th
        Lightning strikes the clocktower at 10.04pm

I'm going to start off by making a few changes to this file. Note that I leave insert mode after typing each line of text. Vim creates a record in the undo history each time I return to normal mode, so this gives me some control over the level of granularity that I'll see when I use the undo and redo commands.

    1955, November 5th
        George McFly falls out of a tree and is hit by a car.
        Lorraine Baines nurses George, and thinks he's cute.

    1955, November 12th
        George McFly takes Lorraine Baines to the dance, and they kiss.
        Lightning strikes the clocktower at 10.04pm

You're no doubt used to the idea that you can use the undo command to go backwards in time, and then you can play it forwards again by using the redo command. But typically you can only move backwards and forwards along a single line of history. If I roll back a couple of edits then make a change to the document, I create a new branch in the timeline of the document's history. Let me just add one more change, to complete the story...

    1955, November 5th
        Marty McFly is hit by a car.
        Lorraine Baines nurses Marty, and thinks he's cute.

    1955, November 12th
        Marty Mcfly takes Lorraine Baines to the dance, and they kiss.
        Marty McFly invents Rock and Roll
        George McFly and Loraine Baines kiss.
        Lightning strikes the clocktower at 10.04pm

Now, when I invoke the undo command, I can get back to the state where the history of the document forked, but the redo command is fixed on the track that I just created. I can go back and forwards on the new timeline as often as I like, but the original timeline cannot be retrieved.

That is the world view of your average software. But Vim has a flux capacitor built in, which allows you to revisit undo states in the document's history that are beyond the reach of the redo command.

Lets replay each of the edits I made earlier, and this time we'll keep track of them using a graphical representation of the timeline. Each node in this graph represents the state of the document after a single editing operation. Having made a couple of edits, I'll invoke the undo command. This doesn't create a new node in the graph, it just reverts the document to a previous state.

Lets see what happens when I edit an earlier version of the document. This creates a fork in the timeline, and now when I use the undo and redo commands, they move me backwards and forwards along this new branch of history. It looks as though the old changes are no longer accessible.

But see how I've numbered each of the nodes in the graph, in the order that they were created? Well, you can consider this to be a chronological list of changes. If we redraw the graph so that the nodes are listed in chronological order, then suddenly we are back to having a linear structure. Vim provides commands that enable you to traverse this list forwards and backwards. Using these commands, it is possible to return to the states that were unreachable using the standard undo and redo commands.

The list of chronological changes can be difficult to follow, because two states may be positioned beside each other even though they are several steps apart in the graph. If we redraw the graph so that the fork is visible, but maintain the position of the nodes so that they are in chronological order, we get a more comprehensible overview of the undo tree. You can see where the document history diverged, but you can also see each state of the document in chronological order.

The `undo` and `redo` commands can move forwards and backwards along the *mainline* branch, but they are not able to switch between branches. When you step along a single track with undo and redo, each update corresponds to a coherent edit, so you can follow the evolution of your document.

The `g+` and `g-` commands traverse the list of historical states of the document. This means that they are capable of switching from one undo branch to another. Beware that jumping between branches can be disorienting, just like time travel. Nevertheless, this powerful feature means that you are never barred from revisiting an earlier state of your document.

Note that the document timeline records a time-stamp for each historical state, which makes it possible to revert the document to how it looked a particular number of seconds, minutes, hours or days before the current state. I can assure you, running `:earlier 20s` has saved my bacon on more than one occasion!

Introducting Gundo.vim
======================

Vim's notion of history is powerful, but it is difficult to get your head around. Wouldn't it be nice if you could view an interactive visualisation of the history tree? Well, now you can, using Steve Losh's G-undo plugin.

Installation is straightforward, you'll find a link to instructions in the shownotes for this episode. The plugin does not provide a keymapping to toggle the history viewer, so you'll probably want to create one in your vimrc file.

I've set up `<f5>` so that it toggles the history window. In the top pane, we get an ascii representation of the history graph, and the bottom window shows you a diff between the selected node and its historical predecessor. I can use the `j` and `k` keys to traverse up and down the nodes of the tree, and pressing enter sets the document to the specified state. This makes it much easier to work with Vim's history tree. I highly recommend installing it and playing around with it.

The plugin requires Vim 7.3 or later, so if you haven't updated yet, this is a good reason to get the latest version. Also, the plugin requires Vim built with support for python scripting. 
