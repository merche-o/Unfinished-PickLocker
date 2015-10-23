/**
* Game.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
	status_room : {type:'string', required: true},
	status_game:  {type:'string', required: true},
	nb_turn:  {type:'integer', defaultsTo: 0},
	  _player1 : {
	    model:'User',

	     },
	  _player2 : {
	      model:'User',
	  },
      }
};

