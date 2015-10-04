/**
* Bonus.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {
    attributes: {
      owner      : { 
	    model: "User",
	    required: true,
      },
      name: {
	    type: "string",
	    unique: true,
	    required: true
	},
	type: {
	    type: "string",
	    required: true,
	    enum: ["bonus1","bonus2"]
	},
    }
}