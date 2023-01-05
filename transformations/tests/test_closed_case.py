import pytest
import test_base


class TestClosedCase(test_base.TestBase):

    def test_mpam_aggregate_closed_cases(self):
        record = self.get_result("public.mpam_aggregate_closed_cases")

        assert record[0] == 3
        assert record[1] == 2
        assert record[2] == 1

    def test_mpam_aggregate_closed_cases_by_age(self):
        record = self.get_result("public.mpam_aggregate_closed_cases_by_age")

        assert record[0] == 3
        # not sure why created defaults to start of the month
        # need to check on the logic here within the flatten_audit_data
        assert record[1] >= 1
        assert record[1] <= 31

    def test_mpam_aggregate_closed_cases_by_outcome(self):
        record = self.get_result(
            "public.mpam_aggregate_closed_cases_by_outcome")

        # we do not know upheld/not upheld/partiall upheld
        # values are just default totals as above in mpam_aggregate_closed_cases
        assert record[0] == 3
        assert record[1] == 3
        assert record[2] == 3
