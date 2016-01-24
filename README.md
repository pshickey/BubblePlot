# BubblePlot
## Inspiration
In prior projects we have used R and RStudio to process and visualize data, but this approach had limited capability for interaction. We were intrigued by Thalmic's Myo and how it could be used to interact with data in a more natural and immersive way. This led us to develop BubblePlot, a Processing sketch that creates new potential for how we visualize data.

## What it does
BobblePlot uses the Myo for Processing library to incorporate the Myo's gesture recognition into a interactive visualization of a data. Here's what each of the recognized gestures does:

**Fist**: Collapse Bubbles to the center of the sketch, cycle the value the Bubbles are sized and sorted by, and redraw the Bubbles.

**Fingers Spread**: Cycle the text entry of each Bubble or turn text off. If text is not displayed, data values will also be hidden showing only the circles.

**Double Tap**: Toggle on/off panning over the data using the Myo's orientation.

**Wave In**: Zoom in

**Wave Out**: Zoom out

The Processing sketch takes each line of the input file and creates a Bubble which can hold any number of strings or numbers. The sketch then draws each Bubble where the relative sizes represent relative values for the data. The user can then interact with the data using the various gestures in order to create a fluid, intuitive presentation of the data.

## How we built it
We wrote a python script to read in a csv file and create the format string used by Processing sketch by recognizing whether the data was a number or a string. The script wrote the file then read in by Processing and used to visualize the data.

## Challenges we ran into
There's a varied level of programming experience on the team which contributed to some stalled progression, but we were able to surpass this by using Pair Programming.

## Accomplishments that we're proud of
This was both of our first Hackathon. We're proud to have realized a concept under a time constraint with unfamiliar hardware and look forward to future hacks!

## What we learned
Interacting with the Thalmic Myo and it's gesture controls. Data processing and regular expressions in Python.

## What's next for BubblePlot
Sequences of gestures to open more options for interacting with the data.
Interaction with a second Myo to allow Minority Report like manipulation of the data.
