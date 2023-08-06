# mazesolving

Using the wall follower method, implemented a synchronous sequential circuit in order to efficiently solve any simply connected maze.

It works by checking whether a wall exists on the cell to the right of the current position. If so, it rotates counterclockwise and checks again. 
Otherwise, the current position updates with the coordinates of the verified cell, to signal moving there.  

The automaton can be in 1 of 10 states at any given moment:
  * 1 at the starting point;
  * 8 for checking for walls and moving in any of the 4 directions(2 each);
  * 1 on reaching the exit.

The algorithm passed all the tests (mazes) attached to the assignment successfully.
