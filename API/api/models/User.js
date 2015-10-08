/**
 * User
 * @description :: Model for storing users
 */

module.exports = {
  schema: true,

  attributes: {
    username: {
      type: 'string',
      required: true,
      unique: true,
      alphanumericdashed: true
    },

    password: {
      type: 'string'
    },

    email: {
      type: 'email',
      required: true,
      unique: true
    },

    firstName: {
      type: 'string',
      defaultsTo: ''
    },

    lastName: {
      type: 'string',
      defaultsTo: ''
    },
  
    life: {
	    type:'integer',
	    defaultsTo: 3
    },
    
    list_bonus:{
	    collection:'Bonus',
	    via :'owner',
	    defaultsTo: ""
     },
  
    code: {
	    model:'Code',
	    via:'id_player'
    },

    try: {
	    type:'integer',
	    defaultsTo:0
    },

    photo: {
      type: 'string',
      defaultsTo: '',
      url: true
    },

    socialProfiles: {
      type: 'object',
      defaultsTo: {}
    },

    toJSON: function () {
      var obj = this.toObject();

      delete obj.password;
      delete obj.socialProfiles;

      return obj;
    }
  },

  beforeUpdate: function (values, next) {
    if (values.password) values.password = HashService.bcrypt.hashSync(values.password);
    next();
  },

  beforeCreate: function (values, next) {
    if (values.password) values.password = HashService.bcrypt.hashSync(values.password);
    next();
  }
};
