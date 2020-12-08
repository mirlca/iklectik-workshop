// Tutorial adapted from the MIRLC help and live demoed by Sam Roig on 7 December 2020

// MIRLC instantiation

// Let's create a temporary directory where to store the downloaded data:
p = "/tmp/MIRLC/"

// you can use single letters as throwaway variables in supercollider

/////////////////////
// ALTERNATIVE:
// If you wish to keep the downloaded samples and metadata
// Create a directory to put MIRLC's data in home directory:
p = "HOME".getenv ++ "/MIRLC"; // path for Mac/Linux

// For simplicity: you can also hardcode the path (Windows/Mac/Linux):
p = "/Users/s/MIRLC";
/////////////////////

File.mkdir(p); // Create the directory if it's not there yet

// Let's instantiate a MIRLCRep object
a = MIRLCRep.new(path: p);

// We haven't loaded a sample yet!
// Let's get a random one from FreeSound...
a.random

/// it can take a bit of time for the samples to download
a.printsynths
a.printbuffers

// Playback control
a.stop
a.play

// The functionality to remove the sample from the database is not
// yet implemented!
// For now, you'll have to stoically accept whatever the FreeSound overlords
// provide you... or create a new MIRLC instance.

// There's the freeall method but it's currently buggy and will bring
// some trouble. It's best to avoid it for now.

a.stop

a.free

a = MIRLCRep.new(path: p)
// The sound should play back... looped!

// Executing the above method again will give us a different sound (try it a few times)
// In SuperCollider you can always kill all the processes with Cmd-. (Max) or Ctrl-. (Windows). Use for emergencies.

a.random

// We can also query descriptor properties about the sound:
// Let's check bpm:

a.whatbpm

// If there's a specific sound in FreeSound that we want to use, we can load it using it's id like so

a.id(399744) // Ambience, Florida Frogs Gathering, A
a.id(457447) // Rain Sound and Rainforest.mp3

// Here's another one:
a.id(19247)

// To find more sounds, visit FreeSound, find a sound you like and take note of the last number in its URL. Example:
// https://freesound.org/people/suzenako/sounds/537060/
a.id(537060)

// But if you are performing or "in the zone", browsing FreeSound is likely to break your flow.
// We can use other methods to search for new sounds without leaving SuperCollider.
// Let's see some examples...

// random(size=1)
a.random


a.random(3)

// See information about all the buffers/soundfiles we have downloaded so far
a.printbuffers


// We can also search for specific user-created tags
a.tag("nail", 3)
a.tag("chimes", 2)
a.tag("noise", 2)
a.tag("hammer", 2)
a.tag("grain", 2)
a.tag("humming", 3)

a.stop

// And get sounds by content or by content with an optional filter

// For reference these are the method's arguments
// content(size=1, feature = 'dur', fvalue = 1, fx = 'conf', fxvalue = 'hi')

a.content // sounds of 1 sec of duration
a.content(1, 'dur', 10) // sounds of 10 sec of duration
a.content(1, 'dur', 1, 'key', 'A')
a.content(1, 'dur', 4, 'scale', 'minor')
a.content(1, 'dur', 1, 'conf', 'lo')
a.content(2, 'pitch', 100, 'conf', 'lo')
a.content(1, 'key', 'Asharp')
a.content(5, '.lowlevel.spectral_complexity.mean:',1, 'conf', '[0 TO 0.3]') // Using directly Essentia's format
a.content(1, 'bpm', 120)

// Get similar sounds by example
// Arguments:
// similar(targetnumsnd=0, size=1) // which buffer and how many to retrieve
a.similar
a.similar(0)
a.similar(0, 2)
b.similar(1)

a.play

// Get similar sounds by filter
// Arguments:
// filter (targetnumsnd=0, size=1, fx = 'conf', fxvalue = 'hi')

a.content(1, 'dur', 4, 'scale', 'minor')
a.filter(1, 1,'conf','lo')
a.filter(1, 1,'conf','hi')
a.filter(2, 1,'conf','hi')

a.content(1, 'dur', 2)
a.filter(1, 1,'mfcc0','neg')
a.filter(1, 1,'mfcc1','1720')
a.filter(1, 1,'mfcc1','2040')


// Analyze sounds by content:

a.random(1)
a.whatpitch
a.content(1, 'pitch', 660)
a.similar

a.random(1)
a.whatbpm
a.content(1, 'bpm', 116)
a.similar
a.whatpitch
a.content(1,'pitch', 220)

// Use the following method to obtain more analysis information
// than you probably need ;)
a.analyze; // full list as it comes from the Freesound quark

// Playback controls:
a.sequence // Play the sounds in sequence
a.parallel // Play them in parallel

a.solo(4)  // Self-explanatory (the argument selects the sound)
a.mute(2)  // Same but for muting

a.muteall  // Global mute

a.stop
a.play

// Visualizing sounds and other information:

a.plotserver // Plots all the sounds that are playing (aggregates instances)
a.scope      // See the waveform in realtime

// Print information to the Post window
a.printbuffers // Print information all of the buffers we have downloaded
a.printsynths  // Print all of the synths we have created
a.printall     // Print all of the above

// We should really add a Frequency scope and a Spectogram as well

// That's it for this overview... time to experiment!