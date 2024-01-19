package {group_id}.{artifact_id}

class BarSuite extends munit.FunSuite {
  test("numbers") {
    val obtained = 42
    val expected = 42
    assertEquals(obtained, expected)
  }

  test("hello") {
    assertEquals(Bar.greeting, "hello world from scala")
  }
}
