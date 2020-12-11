
// Tutorial adapted from the MIRLC2 help and live demoed by Sam Roig on 9 December 2020

// MIRLC2
//
// This class is an incremental improvement over MIRLC.
// It provides improved querying and some automatic methods.
// And it can also apply effects to the downloaded sounds.
//
// It is is still somehow buggy.
//
// Besides this document, or looking at the source, you can also refer to
// the earlier MIRLC tutorial.
//
// This recording of a performance by Anna Xambó can also serve you as a guide.
// https://vimeo.com/439543308

p = "/tmp/MIRLC2/"; // Define a patch for out data
File.mkdir(p);      // This line will create the directory if it doesn't exist yet.

// Let's create a instance of MIRLCRep2 and assignt it to variable
a = MIRLCRep2.new(path: p);

// Search by tag (just like with MIRLCRep)
a.tag("prayer");

// Playback controls
a.sequence // sequential playback, one sample in the bucket after another
a.parallel // parallel playback, all at the same time
a.stop
a.play         // args: |rate=1| (can be negative)
a.play(1)    // args: |rate=1| (can be negative)
a.play(-0.5)   // args: |rate=1| (can be negative)
a.mute   // args: |targetnumsnd=0|
a.unmute // args: |targetnumsnd=0|
a.solo   // args: |targetnumsnd=0|

// Some useful functions to know what we're dealing with:
a.whatid;  // ID
a.whatkey; // Key
a.pitch;   // Mean Pitch (Hz)
a.whatbpm; // BPM (beats per minute)
a.whatvol; // Master Volume
a.whatdur; // Duration (in secs)

// The following function retrieves all content-based descriptors listed in the  Analysis Descriptor
// Documentation from the FreeSound API:
// "https://www.freesound.org/docs/api/analysis_docs.html#analysis-docs"
// The result can be filtered using the descriptors request parameter passing a list of comma separated descriptor names chosen from the available descriptors e.g. 'descriptors=lowlevel.mfcc,rhythm.bpm'
// args: |descriptors, action|
a.analyze;
a.analyze('descriptors=lowlevel.mfcc,rhythm.bpm')

// Create another instance of MIRLCRep2 to put other sounds in it
b = MIRLCRep2.new(path: p);
b.id(279086); // Get a sound by id
b.whatid;     // Use this to take note of sounds you like.
b.similar(0, 4);
b.sequence
b.solo(1)
b.muteall
// QUERY BY CONTENT
// This function gets [1..n] sounds by one defined feature and fx, and plays them
b.content(1, 'dur', 0.5) // args: { |size = 1, feature = 'dur', fvalue = 1, fx = 'conf', fxvalue = 'bypass' |
b.content(1, 'pitch', 110)

// FUNCTIONS TO KEEP ADDING SOUNDS
// This function gets [1..n] similar sounds from a target sound filtered by a fx

// This function gets [1..n] similar sounds from a target sound, usually the first sound from the dictionary
b.similar(0, 2)  // args: | targetnumsnd = 0, size = 1 |
b.filter(0, 4, "key", 'A'); // args: targetnumsnd = 0, size = 1, fx = 'conf', fxvalue = 'bypass'
b.filter(0, 4, "bpm", 70)

// AUTOMATIC FUNCTIONS
// Use the following functions carefully: don't execute them simultaneously (let the process end).
b.similarauto(0, 4, 30)  // args: |targetnumsnd = 0, size = 3, tempo = 30|

// playauto changes speed and reverses the samples randomly
b.playauto     // args: |times = 4, tempo = 30|
b.playautodown; // Varispeed-like playback. args: |start = 1, end = 0, times = 5, tempo = 10|
a.autochopped(32,1);  // Chop the audio and play some fragments backwards. args: |times = 4, tempo = 1|

b.sequence;

// A new instance for random sounds
z = MIRLCRep2.new(path: p);
z.random(4); // Get 4 random sounds
// wait... :)

z.sequence;  // Listen to them in sequence to lessen the (highly likely) chaos
// More often than not, random search is probably not the best strategy...
z.stop;      // Get some rest.

// Let's see what's the mean pitch of the 'prayer' file is.
a.whatpitch; // Take a look at the post window: 229.90976804768104 Hz

// Let's search for another sound with the same pitch and store it in b
// Ideally we'd query by key but this functionality is not implemented yet.
b.pitch(1,229,'conf','hi');

// Not quite what I was looking for...
b.mute(0);

// Possibly the call for prayer is in sung in A
// The offset in 9Hz is possibly an artifact of averaging the pitch of the melody.
// Let's try with 220 Hz...
a.pitch(1,220,'conf','hi');

// Better!

b.pitch(1, 880 * 3/2, 'conf', 'hi'); // a fith, a couple of octaves above
b.stop

// Let's add a bit of rhythm:
a.whatbpm // Check the bpm of the original file: 139.6686541180513

// create a third instance of MIRLCRep2 for the rhytmic part
c = MIRLCRep2.new(path: p);
c.tag("beat", 4); // Let's search for a beat. We'll audition 4.
c.muteall; // Let's mute them all, then audition one by one.
c.solo(2);

// Dissonance
a.diss(1,fxvalue:'hi') // args: |size = 1, fvalue = 1.0, fx = 'conf', fxvalue = 'lo'|

// Let's search a similar sound to the call for prayer
a.similar(1, 2)

a.whatkey
a.key

// We can narrow our search with additional tags like so:
a.tag("water" + "drop");

a.whatpitch
a.whatbpm

a.similar(0, 2, 108)
a.sequence

// new instance
d = MIRLCRep2.new(path: p);
// Search by tag (just like with MIRLCRep)
d.tag("prayer");
d.filter(0, 4, "key", 'A');
d.filter(0, 4, 'bpm', 220); // args: targetnumsnd = 0, size = 1, fx = 'conf', fxvalue = 'bypass'

// We can also narrow our search with additional tags.
// Let's mute a for now and create a new instance.
a.muteall;

e = MIRLCRep2.new(path: p);

r = Routine( {
	e.tag("one" + "number");
	2.yield; // inserting a tiny wait to make sure they will be downloaded in order
	e.tag("two" + "number");
	2.yield;
	e.tag("three" + "number");
	2.yield;
	e.tag("four" + "number");
	2.yield;
	e.tag("five" + "number");
	2.yield;
	e.tag("six" + "number");
	2.yield;
	e.tag("seven" + "number");
	2.yield;
	e.tag("eight" + "number");
	2.yield;
});

r.stop;
e.sequence;

// FX
a.play // back to the first sound
a.bypass // bypass the FX
// This function changes the volume of the whole group from 0 to 1.
a.volume(0.5); // args: |vol = 0.2|
// This function fades out all synths with a smooth fade out
a.fadeout;    // args: |release = 1.0|
// MIRLC2 provides some simple built-in FX (consider adding yours!)
a.delay         // delay (no parameters yet)
a.lowpf(550)         // low pass filter (no parameters yet)
//a.highpf(8100)
a.bandpf
a.reverb
a.bitcrush



// VISUALIZATION, PRINTING
// FUNCTIONS: scope, plotserver, printmedata, printsynths, printbuffers, printall
a.scope
a.plotserver
a.info;       // This function prints the FS metadata information for all downloaded sounds
a.printmedata // This function prints the FS metadata information for all downloaded sounds
a.printsynth // This function prints the synth information and associated FS metadata information of the current active sound
a.printsynths // This function prints the synths information and associated FS metadata information for all the active sounds
a.printbuffers // This function prints the buffers information and associated FS metadata information for all downloaded sounds
a.printall // Print everything (metadata, synths, buffers)

// EXTENSIONS (not in your EXTENSIONS yet)
// I'll briefly show you how to introduce your own changes
a.soloN([1,3])
a.muteN([3,2])
a.highpf(900)
a.bandpf(1000, 1000)

