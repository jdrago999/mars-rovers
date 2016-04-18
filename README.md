
# Mars Rover Quiz

## Task Description

Candidates should spend no more than 8 hours working on this exercise.

For the solution, we request that you use the specified language. You may use external libraries or tools for building or testing purposes. Specifically, you may use unit testing libraries or build tools available for your chosen language.

Please also include a brief explanation of your design and assumptions along with your code.

### INTRODUCTION TO THE PROBLEM

There must be a way to supply the application with the input data via a text file (a textarea is suitable for a JavaScript-based solution). The application must run. You should provide sufficient evidence that your solution is complete by, as a minimum, indicating that it works correctly against the supplied test data. Please note that you will be assessed on your judgment as well as your execution.

### MARS ROVERS

A squad of robotic rovers are to be landed by NASA on a plateau on Mars. This plateau, which is curiously rectangular, must be navigated by the rovers so that their on-board cameras can get a complete view of the surrounding terrain to send back to Earth.

A rover's position and location is represented by a combination of x and y co-ordinates and a letter representing one of the four cardinal compass points. The plateau is divided up into a grid to simplify navigation. An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.

In order to control a rover, NASA sends a simple string of letters. The possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the rover spin 90 degrees left or right respectively, without moving from its current spot. 'M' means move forward one grid point, and maintain the same heading.

Assume that the square directly North from (x, y) is (x, y+1).

### INPUT:

The first line of input is the upper-right coordinates of the plateau, the lower-left coordinates are assumed to be 0,0.

The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover's position, and the second line is a series of instructions telling the rover how to explore the plateau.

The position is made up of two integers and a letter separated by spaces, corresponding to the x and y co-ordinates and the rover's orientation.

Each rover will be finished sequentially, which means that the second rover won't start to move until the first one has finished moving.

### OUTPUT

The output for each rover should be its final co-ordinates and heading.

### INPUT AND OUTPUT

Test Input:

```
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
```

Expected Output:

```
1 3 N
5 1 E
```

## RUNNING THE TESTS

### Within Docker

```bash
docker build --no-cache -t covata/rover . && \
  docker run -t -v $(pwd):/opt/mars-rover covata/rover bundle exec rspec
```

### On your host OS

NOTE: Requires Ruby 2.3.0+

```bash
bundle
bundle exec rspec
```

## Running the Code

### Within Docker

(First, build the container):

```bash
docker build --no-cache -t covata/rover .
```

(Then, you can run tests as many times as you want)

```bash
docker run -t -v $(pwd):/opt/mars-rover covata/rover bundle exec bin/dispatch-rovers spec/fixtures/input.txt
```

### On your host OS

NOTE: Requires Ruby 2.3.0+

```
bundle
bundle exec bin/dispatch-rovers spec/fixtures/input.txt
```
