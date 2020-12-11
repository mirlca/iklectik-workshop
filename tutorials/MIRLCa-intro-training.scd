
// Before instantiating MIRLCa, it is recommended that you define what path you will be storing the generated files.
// The slash at the end is very important.
// Please note: the directory should exist!
// Please note: the three files "model.JSON", "pca.JSON" and "standardizer.JSON" should exist inside this folder

p = "/Users/anna/Desktop/MIRLCa/"

// MIRLCa instantiation

a = MIRLCa.new(path: p)

// Start the training

a.starttraining

// If you like the sound, execute this command

a.ok

// If you don't like the sound, execute this command

a.ko

// A new sound will appear, sometimes you need to wait. Keep saying if you like the sound or not.
// Once you are done, you can stop the training.

a.stoptraining

//

a.save
