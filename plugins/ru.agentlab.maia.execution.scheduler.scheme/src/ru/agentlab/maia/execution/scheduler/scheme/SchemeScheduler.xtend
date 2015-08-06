package ru.agentlab.maia.execution.scheduler.scheme

import java.util.concurrent.ConcurrentHashMap
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.IMaiaExecutorNode
import ru.agentlab.maia.execution.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.bounded.IMaiaBoundedExecutorScheduler

class SchemeScheduler implements IMaiaBoundedExecutorScheduler {

	val static LOGGER = LoggerFactory.getLogger(SchemeScheduler)

	val stateMapping = new ConcurrentHashMap<String, IMaiaExecutorNode>

	@Inject
	IMaiaExecutorSchedulerScheme scheme

	@Inject
	IMaiaContext context

	@Accessors
	var IMaiaExecutorScheduler parentNode

	@PostConstruct
	def void init() {
		context.set(KEY_CURRENT_CONTEXT, null)
		parentNode = context.parent.get(IMaiaExecutorScheduler)
		if (parentNode != null) {
			LOGGER.info("Add node [{}] to scheduler [{}]...", this, parentNode)
			parentNode.add(this)
		}
	}

	override IMaiaExecutorNode getCurrentNode() {
		return context.get(KEY_CURRENT_CONTEXT) as IMaiaExecutorNode
	}

	override getNextNode() {
		val currentResult = if (currentNode != null) {
//				currentContext.get(IMaiaContextAction.KEY_RESULT)
			} else {
				null
			}
		val nextState = scheme.getNextState(currentResult)
		val nextContext = stateMapping.get(nextState)
		return nextContext
	}

	override synchronized link(IMaiaExecutorNode context, String stateName) {
		val state = scheme.allStates.findFirst [
			name == stateName
		]
		if (state == null) {
			throw new IllegalArgumentException("Scheme have no state " + stateName)
		}
		stateMapping.put(stateName, context)
	}

	override synchronized remove(IMaiaExecutorNode context) {
		stateMapping.remove(context)
	}

	override synchronized removeAll() {
		stateMapping.clear
	}

	override synchronized isEmpty() {
		return stateMapping.empty
	}

	override add(IMaiaExecutorNode context) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}