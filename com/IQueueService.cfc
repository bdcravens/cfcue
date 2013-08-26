<cfinterface>

	<cffunction name="init">
		<cfargument name="configBean"/>
	</cffunction>

	<cffunction name="getQueuesList" />

	<cffunction name="getMessageCount">
		<cfargument name="queueName"/>
	</cffunction>

	<cffunction name="getNextMessage">
		<cfargument name="queueName"/>
	</cffunction>

	<cffunction name="setPersistenceService">
		<cfargument name="persistenceService"/>
	</cffunction>

	<cffunction name="getPersistenceService"/>

	<cffunction name="setNewMessage">
		<cfargument name="queueName"/>
		<cfargument name="batchId"/>
		<cfargument name="taskId"/>
		<cfargument name="workerArgs"/>
	</cffunction>

</cfinterface>