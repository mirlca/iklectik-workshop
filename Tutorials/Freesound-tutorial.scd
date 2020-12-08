// Tutorial adapted from the Freesound.sc help and live demoed by Sam Roig on 7 December 2020

// You can quickly test whether Freesound.quark works by writing "Freesound" in the code editor and pressing cmd+D to open the Help file.

Freesound

// If you don't see an error in the Post window, you're all set!

// To execute a line of code, move the cursor to that line and
// press Shift+Enter.

// This will boot the scsynth Server
Server.local.boot;

// Token Authentication (FreeSound wants to know who's using their database)
// https://www.freesound.org/docs/api/authentication.html#token-authentication
// Usually this is personal (associated to each FreeSound user).
// We'll use a generic one during this workshop.
// Remember to create your own afterwards!
//
// After obtaining the API key, this is the only thing you need to do for authenticating with the token method:

// You can also select several lines and execute them in one go
// using the same key combination we've seen above (Shift-Enter)
// Just make sure to first select those lines (you can do this using the mouse
// but this is faster:
//    - Press and hold the Shift Key.
//    - Use the cursor keys to trim your selection.
//    - Hit Enter to execute.
Freesound.authType = "token"; // default, only needed if you changed it
Freesound.token="efdICNV9RPbOF6deLZvIPyrAYSWlQB13dUSYpcRX";

// Get sound by id:
// Now we'll use FreeSound's identifiers to query a sound.
// You can obtain these id's either from previously downloaded samples
// or by taking note of the number that appears at the end of FreeSound URL's.

// https://www.freesound.org/docs/api/resources_apiv2.html#sound-instance

// To execute a block of code, move the cursor to that line and
// press Shift+Enter.
(
FSSound.getSound(457447, {|f|
    ~snd = f;
    ~snd["name"].postln;
});
)


// Metadata about the sound is loaded from the JSON response into a dictionary, and also accessible using object syntax
~snd.dict.keys;
~snd.name;
~snd["name"];
~snd.tags;
~snd.duration;
~snd.url;

// preview url keys have dashes, only work as dict keys
~snd.previews["preview-hq-ogg"];

// Execute the line above and take a look at the post window.
// You can use that URL in the browser.

// *** Try re-executing this code
(
// This block of code will download the preview

~preview = ~snd.retrievePreview("/tmp/", {
        ~buf = Buffer.read(s, "/tmp/" ++ ~snd.previewFilename);
        "done!".postln;
});

"/tmp/" ++ ~snd.previewFilename.postln;
)

// Now that we've downloaded the sound to our computer.
// Let's play it!
~buf.play;

// Finding Similar sounds
// https://www.freesound.org/docs/api/resources_apiv2.html#similar-sounds

~snd.getSimilar( action:{|p| ~snd = p[1] ;})
~snd["name"].postln;

// Now go back and re-execute the code for downloading the preview again (***)
// And play the buffer once more:
~buf.play;

// Analysis
// https://www.freesound.org/docs/api/resources_apiv2.html#sound-analysis
// https://www.freesound.org/docs/api/analysis_index.html

(
~snd.getAnalysis( "lowlevel.pitch", {|val|
            val.lowlevel.pitch.mean.postln;
}, true)
)

// Text search
// https://www.freesound.org/docs/api/resources_apiv2.html#text-search

(
FSSound.textSearch( query: "glitch", filter: "type:wav",params:('page':2), action:{|p|
    ~snd = p[0]; // first result
    ~snd.name.postln;
});
)

(
FSSound.textSearch( query: "duck", filter: "type:wav",params:('page':2), action:{|p|
    ~snd = p[0]; // first result
    ~snd.name.postln;
});
)

// Content-based search:
// https://www.freesound.org/docs/api/resources_apiv2.html#content-search

(
FSSound.contentSearch(
    target: '.lowlevel.pitch.mean:200',
    filter: '.lowlevel.pitch_instantaneous_confidence.mean:[0.8 TO 1]',
    params: ('page':2), action: {|pager|
            ~snd = pager[0];
            ~snd.name.postln;
    }
);
)

// Combined (text and content) search:
// https://www.freesound.org/docs/api/resources_apiv2.html#combined-search

(
FSSound.combinedSearch(query: "glitch", filter: "type:wav",
    descriptorsFilter: ".lowlevel.pitch_instantaneous_confidence.mean:[0.8 TO 1]",
    params:('page': 4), action:{|pager|
        ~snd = pager[0];
        ~snd.name.postln;
    }
);
)