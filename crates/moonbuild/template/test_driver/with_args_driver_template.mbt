// Generated by moon test.

fn moonbit_test_driver_internal_error_to_string(x : Error) -> String = "%error.to_string"

typealias Moonbit_Test_Driver_Internal_No_Args_Function = () -> Unit!Error

typealias Moonbit_Test_Driver_Internal_With_Args_Function = (@moonbitlang/core/test.T) -> Unit!Error

typealias Moonbit_Test_Driver_Internal_With_Bench_Args_Function = (@moonbitlang/core/bench.T) -> Unit!Error

typealias Moonbit_Test_Driver_Internal_No_Args_Map = @moonbitlang/core/builtin.Map[
  String,
  @moonbitlang/core/builtin.Map[
    Int,
    (Moonbit_Test_Driver_Internal_No_Args_Function, @moonbitlang/core/builtin.Array[String]),
  ],
]

typealias Moonbit_Test_Driver_Internal_TestDriver_With_Args_Map = @moonbitlang/core/builtin.Map[
  String,
  @moonbitlang/core/builtin.Map[
    Int,
    (Moonbit_Test_Driver_Internal_With_Args_Function, @moonbitlang/core/builtin.Array[String]),
  ],
]

typealias Moonbit_Test_Driver_Internal_TestDriver_With_Bench_Args_Map = @moonbitlang/core/builtin.Map[
  String,
  @moonbitlang/core/builtin.Map[
    Int,
    (Moonbit_Test_Driver_Internal_With_Bench_Args_Function, @moonbitlang/core/builtin.Array[String]),
  ],
]

struct Moonbit_Test_Driver_Internal_Meta {
  filename : String
  index : Int
  attrs : @moonbitlang/core/builtin.Array[String]
}

enum Moonbit_Test_Driver_Internal__F {
  F0(Moonbit_Test_Driver_Internal_No_Args_Function)
  F1(Moonbit_Test_Driver_Internal_With_Args_Function)
  F2(Moonbit_Test_Driver_Internal_With_Bench_Args_Function)
}

struct Moonbit_Test_Driver_Internal__TestCase {
  f : Moonbit_Test_Driver_Internal__F
  meta : Moonbit_Test_Driver_Internal_Meta
}

fn moonbit_test_item_is_bench(item : Moonbit_Test_Driver_Internal__TestCase) -> Bool {
  match item.f {
    Moonbit_Test_Driver_Internal__F::F0(_) => false
    Moonbit_Test_Driver_Internal__F::F1(_) => false
    Moonbit_Test_Driver_Internal__F::F2(_) => true
  }
}

fn moonbit_test_driver_internal_apply_filter(
  no_args_tests : Moonbit_Test_Driver_Internal_No_Args_Map,
  with_args_tests : Moonbit_Test_Driver_Internal_TestDriver_With_Args_Map,
  with_bench_args_tests : Moonbit_Test_Driver_Internal_TestDriver_With_Bench_Args_Map,
  file_filter : String,
  index_filter : Int
) -> Option[Moonbit_Test_Driver_Internal__TestCase] {
  let no_args_filtered_test = match no_args_tests.get(file_filter) {
    Some(index_func_map) => {
      match index_func_map.get(index_filter) {
        Some(func_attrs_tuple) => {
          let k = {
            f: Moonbit_Test_Driver_Internal__F::F0(func_attrs_tuple.0),
            meta: { filename: file_filter, index: index_filter, attrs: func_attrs_tuple.1 },
          }
          Some(k)
        }
        _ => None
      }
    }
    _ => None
  }

  let with_args_filtered_test = match with_args_tests.get(file_filter) {
    Some(index_func_map) => {
      match index_func_map.get(index_filter) {
        Some(func_attrs_tuple) => {
          let k = {
            f: Moonbit_Test_Driver_Internal__F::F1(func_attrs_tuple.0),
            meta: { filename: file_filter, index: index_filter, attrs: func_attrs_tuple.1 },
          }
          Some(k)
        }
        _ => None
      }
    }
    _ => None
  }

  let with_bench_args_filtered_test = match with_bench_args_tests.get(file_filter) {
    Some(index_func_map) => {
      match index_func_map.get(index_filter) {
        Some(func_attrs_tuple) => {
          let k = {
            f: Moonbit_Test_Driver_Internal__F::F2(func_attrs_tuple.0),
            meta: { filename: file_filter, index: index_filter, attrs: func_attrs_tuple.1 },
          }
          Some(k)
        }
        _ => None
      }
    }
    _ => None
  }

  if no_args_filtered_test is Some(_) {
     no_args_filtered_test
  } else if with_args_filtered_test is Some(_) {
     with_args_filtered_test
  } else {
     with_bench_args_filtered_test
  }
}

let moonbit_test_driver_internal_no_args_tests : Moonbit_Test_Driver_Internal_No_Args_Map = { }  // WILL BE REPLACED
let moonbit_test_driver_internal_with_args_tests : Moonbit_Test_Driver_Internal_TestDriver_With_Args_Map = { }  // WILL BE REPLACED
let moonbit_test_driver_internal_with_bench_args_tests : Moonbit_Test_Driver_Internal_TestDriver_With_Bench_Args_Map = { }  // WILL BE REPLACED

pub fn moonbit_test_driver_internal_execute(file_name: MoonbitTestDriverInternalExternString, index: Int) -> Unit {
  let file_filter: String = moonbit_test_driver_internal_get_file_name(file_name)
  let index_filter : Int = index
  let filtered_test = moonbit_test_driver_internal_apply_filter(
    moonbit_test_driver_internal_no_args_tests,
    moonbit_test_driver_internal_with_args_tests,
    moonbit_test_driver_internal_with_bench_args_tests,
    file_filter,
    index_filter
  )
  let mut test_name = ""
  let mut file_name = ""
  let mut message = ""
  match filtered_test {
    Some(item) => {
      let attrs = item.meta.attrs
      file_name = item.meta.filename
      let name = if attrs.is_empty() { "" } else { attrs[0] }
      let name = if name.length() == 0 {
        item.meta.index.to_string()
      } else {
        name
      }
      let bench_mode = false // WILL BE REPLACED
      match (bench_mode, moonbit_test_item_is_bench(item)) {
        (true, false) | (false, true) => {
          @moonbitlang/core/builtin.println("{BEGIN_MOONTEST}")
          @moonbitlang/core/builtin.println(
            "{\"package\": \"{PACKAGE}\", \"filename\": \{file_name.escape()}, \"index\": \"\{index}\", \"test_name\": \{name.escape()}, \"message\": \"skipped test\"}",
          )
          @moonbitlang/core/builtin.println("{END_MOONTEST}")
          return
        }
        _ => ()
      }
      test_name = name
      try {
        let bench_out = if moonbit_test_item_is_bench(item) {
          let it = @moonbitlang/core/bench.new()
          Some(it)
        } else {
          None
        }
        let func = match item.f {
        Moonbit_Test_Driver_Internal__F::F0(f) => f
        Moonbit_Test_Driver_Internal__F::F1(f) =>
            fn() {
              let it = @moonbitlang/core/test.new(name)
              f!(it)
            }
        Moonbit_Test_Driver_Internal__F::F2(f) =>
            fn() {
              let it = match bench_out {
                Some(inner) => inner
                _ => panic() // unreachable
              }
              f!(it)
            }
        }
        func!()
        match bench_out {
          Some(inner) => {
            let s = inner.dump_summaries()
            message = "@BATCH_BENCH { \"summaries\": \{s} }"
          }
          None => ()
        }
      } catch {
        @moonbitlang/core/builtin.Failure(e) | @moonbitlang/core/builtin.InspectError(e) | @moonbitlang/core/builtin.SnapshotError(e) | @moonbitlang/core/builtin.BenchError(e) => {
          message = e
        }
        e => {
          message = moonbit_test_driver_internal_error_to_string(e)
        }
      }
    }
    _ => { message = "internal error: failed to filter test with (\{file_filter}, \{index_filter})" }
  }

  let file_name = file_name.escape()
  let test_name = test_name.escape()
  let message = message.escape()
  @moonbitlang/core/builtin.println("{BEGIN_MOONTEST}")
  @moonbitlang/core/builtin.println(
    "{\"package\": \"{PACKAGE}\", \"filename\": \{file_name}, \"index\": \"\{index}\", \"test_name\": \{test_name}, \"message\": \{message}}",
  )
  @moonbitlang/core/builtin.println("{END_MOONTEST}")
}

pub fn moonbit_test_driver_finish() -> Unit {
  // {COVERAGE_END}
}

#test_entry
fn main {
  ()
}

fn moonbit_test_driver_internal_get_file_name(file_name : MoonbitTestDriverInternalExternString) -> String { panic() }
extern type MoonbitTestDriverInternalExternString
