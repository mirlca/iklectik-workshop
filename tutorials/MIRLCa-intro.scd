// Tutorial adapted from the MIRLCa help and live demoed by Anna Xambó on 9 December 2020

// Check this diagram that represents how the MIRLCa performance interface works
// "MIRLCa-performance-interface.jpg"
// In this other diagram it is explained the creation of the model:
// "MIRLCa-creating-a-model.jpg"

// MIRLCa instantiation

a = MIRLCa.new

// Target sound, pick one option / sound id that you like

a.random

a.id(3333)


// Get a similar sound, it will pick the first "good" sound from a list of 10 candidates

a.similar


// If you have more than one sound in the collection, you can point the sound target using the index number of the sound in the collection
// e.g. if there were 3 sounds in group "a", and you want the third sound, the index is number 2. By default it will select the first number (index = 0).

// Therefore a.similar is the same than a.similar(0)

a.similar(1)

// You can build a step-by-step similarity group..

a.similar(2)

// ....

// As it currently stands, the similar function is constrained to have 10 candidates. You may find errors in the post window due to situations not matching the conditions... will fix them as soon as possible!
