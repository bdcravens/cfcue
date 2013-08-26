<cfinterface>

	<cffunction name="init">
		<cfargument name="queueName">
		<cfargument name="messageQueueService">
	</cffunction>

	<cffunction name="perform">
		<!--- arguments struct --->
		<!--- this method will be in the actual worker CFC --->
	</cffunction>

	<cffunction name="perform_async">
		<!--- arguments struct --->
	</cffunction>

	<!--- should default to something like createUUID() --->
	<cffunction name="getNewBatchId"/>
	<cffunction name="getNewTaskId"/>

</cfinterface>