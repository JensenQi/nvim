package {group_id}.{artifact_id}

object Bar extends Greeting with App {
  val x = ""
  val foo = new Foo()
  foo.say()
  println(greeting)

}

trait Greeting {
  lazy val greeting: String = "hello world from scala"
}
