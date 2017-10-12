/**
* Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component{
	// Application properties
	this.name = hash( getCurrentTemplatePath() );
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,0,30,0);
	this.setClientCookies = true;

	this.datasources[ "kafka-panel" ] = {
		class: 'org.h2.Driver',
		connectionString: 'jdbc:h2:./db/kafka-panel;MODE=MySQL'
	};

	this.datasource = "kafka-panel";

	// Java Integration
	this.javaSettings = {
		loadPaths = [ ".\lib" ],
		loadColdFusionClassPath = true,
		reloadOnChange= false
	};

	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE 	 = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY 		 = "";

	// application start
	public boolean function onApplicationStart(){

		queryExecute("
			CREATE TABLE IF NOT EXISTS workers (
				id integer IDENTITY(1,1),
				id_worker_type integer  NOT NULL,
				starttime datetime,
				stoptime datetime,
				thread_name varchar(100),
				host varchar(50),
				PRIMARY KEY (id)
			);
		");

		queryExecute("
			CREATE TABLE IF NOT EXISTS workers_types (
				id integer IDENTITY(1,1),
				name varchar(50) not null,
				description varchar(100),
				component varchar(50) not null,
				topic varchar(50) not null,
				number integer default 0,
				groupname varchar(50),
				PRIMARY KEY (id)
			);
		");

		application.cbBootstrap = new coldbox.system.Bootstrap( COLDBOX_CONFIG_FILE, COLDBOX_APP_ROOT_PATH, COLDBOX_APP_KEY, COLDBOX_APP_MAPPING );
		application.cbBootstrap.loadColdbox();
		return true;
	}

	// application end
	public void function onApplicationEnd( struct appScope ){
		arguments.appScope.cbBootstrap.onApplicationEnd( arguments.appScope );
	}

	// request start
	public boolean function onRequestStart( string targetPage ){
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );

		return true;
	}

	public void function onSessionStart(){
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd( struct sessionScope, struct appScope ){
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
	}

	public boolean function onMissingTemplate( template ){
		return application.cbBootstrap.onMissingTemplate( argumentCollection=arguments );
	}

}
