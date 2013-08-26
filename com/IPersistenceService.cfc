<cfinterface>

	<cffunction name="getBatch">
		<cfargument name="queueName">
	</cffunction>

	<cffunction name="setBatch">
		<cfargument name="queueName">
		<cfargument name="batchId">
	</cffunction>

	<cffunction name="getBatches">
		<cfargument name="queueName">
	</cffunction>

	<cffunction name="setTask">
		<cfargument name="batchId">
		<cfargument name="taskId">
		<cfargument name="taskArguments">
	</cffunction>

	<cffunction name="getTask">
		<cfargument name="taskId">
	</cffunction>

	<cffunction name="getTasks">
		<cfargument name="batchId">
	</cffunction>

	<cffunction name="getFailures">
		<cfargument name="queueName">
	</cffunction>

	<cffunction name="setFailure">
		<cfargument name="taskId">
		<cfargument name="exception">
	</cffunction>

	<cffunction name="setTaskState">
		<cfargument name="taskId">
		<cfargument name="state">
	</cffunction>

	<cffunction name="getTaskStates">
		<cfargument name="taskId">
	</cffunction>

</cfinterface>