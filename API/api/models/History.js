/**
* History.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
	id_game: {
	    type:"integer",
	    unique: true,
	    required: true
	},
	codes: {
	    collection:"Code",
	    defaultsTo:""
	},
       list_bonus:{
	    collection:"Bonus",
      	    defaultsTo: ""
     },
  }
};

