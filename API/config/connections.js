/**
 * Connections API Configuration
 *
 * Connections are like "saved settings" for your adapters.
 * Each model must have a `connection` property (a string) which is references the name of one
 * of these connections.  If it doesn't, the default `connection` configured in `config/models.js`
 * will be applied.  Of course, a connection can (and usually is) shared by multiple models.
 *
 * NOTE: If you're using version control, you should put your passwords/api keys
 * in `config/local.js`, environment variables, or use another strategy.
 */

module.exports.connections = {
  /**
   * PostgreSQL configuration
   * @type {Object}
   */
    /*    postgresql: {
	adapter: 'sails-postgresql',
	database: "dm6dfh3k1i39p",
	host: "ec2-54-197-241-239.compute-1.amazonaws.com",
	user: "fhwdaqjpfygmna",
	password: "XifQQk2M0X7B39kT_EFVNUjPm8",
	port: 5432,
	pool: false,
	ssl: true,
	},*/
 

    postgresql: {
    adapter: 'sails-postgresql',
    database: "PickLocker",
    host: "localhost",
    user: "dev",
    password: "dev",
    port: 5432,
    pool: false,
    ssl: false
    },

  /**
   * MySQL configuration
   * @type {Object}
   */
  mysql: {
    adapter: 'sails-mysql',
    host: "localhost",
    port: 3306,
    user: "dev",
    password: "dev",
    database: "PickLocker",
    charset: 'utf8',
    collation: 'utf8_swedish_ci'
  },

  /**
   * MongoDB configuration
   * @type {Object}
   */
  mongo: {
    adapter: 'sails-mongo',
    host: "localhost",
    port: 27017,
    user: "dev",
    password: "dev",
    database: "PickLocker"
  },

  /**
   * Memory configuration
   * ONLY FOR DEVELOPMENT
   * @type {Object}
   */
  memory: {
    adapter: 'sails-memory'
  },

  /**
   * Disk configuration
   * ONLY FOR DEVELOPMENT
   * @type {Object}
   */
  disk: {
    adapter: 'sails-disk'
    },

  /**
   * Microsoft SQL Server configuration
   * @type {Object}
   */
  sqlserver: {
    adapter: 'sails-sqlserver',
    user: "dev",
    password: "dev",
    host: "localhost",
    database: "PickLocker",
    options: {
      encrypt: false
    }
  },

  /**
   * Redis configuration
   * @type {Object}
   */
  redis: {
    adapter: 'sails-redis',
    port: 6379,
    host: "localhost",
    password: "dev",
    database: "PickLocker",
    options: {
      parser: 'hiredis',
      return_buffers: false,
      detect_buffers: false,
      socket_nodelay: true,
      no_ready_check: false,
      enable_offline_queue: true
    }
  },

  /**
   * OrientDB configuration
   * @type {Object}
   */
  orientdb: {
    adapter: 'sails-orientdb',
    host: "localhost",
    port: 2424,
    user: "dev",
    password: "dev",
    database: "PickLocker",
    options: {
      databaseType: 'graph',
      storage: 'plocal',
      transport: 'binary',
      decodeURIComponent: true,
      removeCircularReferences: false,
      unsafeDrop: false,
      parameterized: true,
      fetchPlanLevel: 1
    }
  },

  /**
   * DynamoDB configuration
   * @type {Object}
   */
  dynamodb: {
    adapter: 'sails-dynamodb',
    accessKeyId: "",
    secretAccessKey: "",
    region: ""
  }
};
