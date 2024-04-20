from pandas import DataFrame
import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


def combined_data(df, df2: DataFrame) -> DataFrame:
    frames = [df, df2]
    result = pd.concat(frames)
        
    return result

@transformer
def transform(data_2, data, *args, **kwargs):
    

    return combined_data(data_2, data)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
