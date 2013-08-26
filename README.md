# cfcue
## Asynchronous CFML Processing

*this is currently a work in progress, and is current pre-alpha quality ... 
meaning it doesn't work so all issues and complaints will be ignored* :-)

I've done a lot of work with message queues and CFML, allowing:
* asynchronous (similar to cfthread)
* distributed (spread load over several machines, all running independently and simultaneously, bound together only by a message queue server)

What's a message queue server? In the general sense, an ephemeral database
that delivers messages - any piece of data - in a guaranteed manner. Usually language agnostic.

This can be accomplished using an event gateway. You listen for new messages, and when one comes, fire off a CFC method. Then repeat, ad infinitum. 

Some disadvantages to this approach:
* ACF - It comes with an ActiveMQ gateway, but other message queue types require a new gateway type, which must be written in Java. You write your own handler, and the logic for populating ActiveMQ (as well as other queue types you implement) must be custom developed.
* Railo - Easy to implement new gateway types - you can use CFML. However, for many MQ servers, you're probably downloading Java and configuring your listeners. All handlers must be custom developed as well, and there's no console other than the gateway screen.
* OpenBD - Doesn't even include event gateways! Honestly, no big deal to write your own - just have a cfthread that you loop around in, and have a way to start it up. Pretty awesome from an integration stand point: it knows how to talk to Amazon's Simple Queue Service. It also known ActiveMQ, letting you write handlers as CFCs, and even has ActiveMQ embedded, so no separate MQ server needed!

Pros and cons abound. Generally, I found myself writing a bunch of custom code that was tightly coupled to my MQ implementation. On top of that, any consoles or business logic needed needed to developed as well.

Then I did some Rails, and came across Resque and Sidekiq. They seemed to accomplish all I wanted. Integrated into the application as opposed to hidden away in the CFML admin. Fast. Handles errors and retries. Great looking console. 

There was still the coupling issue. They both use redis, which while an ideal solution 
for this particular problem, isn't the only problem, and gives you another server to manage.
Personally, I'm a fan of hosted MQs, particularly SQS.

Too bad there isn't a CFML version of resque... so that's what this project is.

Still a work in progress, but here's the feature list:
* pluggable MQ layer - just implement your CFC (see IQueueService.cfc)
* uses event gateways (first go-round will use Railo's; hope to have solutions for OpenBD and ACF as well)
* use Resque/Sidekiq-style API: call your CFC as you normally would, referencing perform_async(); this ends up executing perfom() inside your CFC asynchronously. 
* developed in an object oriented manner, but not tied to a specific framework
* HTML console, again, not tied to a specific MVC framework
* JSON API (not going to call it REST - at this point, not really RESTful)
* ship with some basic adapters (SQS, ActiveMQ, etc)

Some more info on how you'd implement this:

```cfml
/* foo.cfc */
component extends="queueWorker" {
	function init() {
		this.queueName = "fooqueue";
		return this;
	}

	function perform(a,b) {
		// do something .. save to database, whatever
	}
}
```

So to run foo.cfc asynchronously:

```cfml
objFoo = new foo(qSvc); // qSvc implement IQueueService
objFoo.perform_async(a="1",b="bar");
```

Some thoughts on development:
* I'm using interfaces to get the initial API knocked out, as well as provide documentation for additional implementation
* I'm trying to do this object-oriented, but I'm more of a journeyman, less of an academic architect. So if I'm totally missing the boat on naming conventions, patterns, best practices, please let me know.