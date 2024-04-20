from pandas import DataFrame

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test



def lowercase_columns(df: DataFrame) -> DataFrame:
    df.columns = df.columns.str.lower().str.replace(" ", "_")
        
    return df

"""
this function replace null values in 'carrier_delay', 'weather_delay',
nas_delay', 'security_delay', 'late_aircraft_delay' with 0 since delay never occured

"""
def replace_with_zero(df: DataFrame) -> DataFrame:
    
    delay_cols = ['carrier_delay', 'weather_delay', 'nas_delay', 'security_delay', 'late_aircraft_delay']
    
    for cols in df[delay_cols]:
        df[cols] = df[cols].fillna(0)
        
    return df


@transformer
def transform(data, *args, **kwargs):

    lowercase_columns(data)
    replace_with_zero(data)

    data['cancellation_code'] = data['cancellation_code'].fillna('E') # represent null values in cancellation code with 'E'


    
    
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
