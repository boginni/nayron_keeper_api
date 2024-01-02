import 'package:conduit_test/conduit_test.dart';
import 'package:nayron_keeper_api/nayron_keeper_api.dart';

export 'package:conduit_core/conduit_core.dart';
export 'package:conduit_test/conduit_test.dart';
export 'package:nayron_keeper_api/nayron_keeper_api.dart';
export 'package:test/test.dart';

/// A testing harness for nayron_keeper_api.
///
/// A harness for testing an conduit application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<NayronKeeperApiChannel> {
  @override
  Future onSetUp() async {}

  @override
  Future onTearDown() async {}
}
