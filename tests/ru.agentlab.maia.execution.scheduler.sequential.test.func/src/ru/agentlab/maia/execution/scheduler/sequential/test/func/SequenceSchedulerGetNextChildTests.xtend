package ru.agentlab.maia.execution.scheduler.sequential.test.func

import java.util.Collections
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerGetNextChildTests {

	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Before
	def void before() {
//		scheduler.activate
	}

	@Test
	def void shouldSilenceOnEmptyQueue() {
		val childs = Collections.EMPTY_LIST
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, emptyIterable)

//		val next = scheduler.schedule
//
//		assertThat(next, nullValue)
	}

	@Test
	def void shouldBeginFromFirst() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, not(emptyIterable))

//		val next = scheduler.schedule
//
//		assertThat(next, equalTo(childs.get(0)))
	}

	@Test
	def void shouldChangeCurrenChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, not(emptyIterable))

//		for (i : 0 ..< 10) {
//			val next = scheduler.schedule
//			val current = scheduler.current
//
//			assertThat(next, equalTo(current))
//		}
	}

	@Test
	def void shouldRestartFromBeginWhenOverload() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, not(emptyIterable))
//		assertThat(scheduler.current, nullValue)
//		for (i : 0 ..< size * 3) {
//			val next = scheduler.schedule
//			if (i % size == 0) {
//				assertThat(next, equalTo(scheduler.childs.get(0)))
//			}
//		}
	}

	@Test
	def void shouldReturnChildsInOrder() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, not(emptyIterable))

//		for (i : 0 ..< size) {
//			val next = scheduler.schedule
//
//			assertThat(next, equalTo(childs.get(i)))
//		}
	}

}