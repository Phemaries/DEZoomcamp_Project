from pandas import DataFrame
import pandas as pd
import numpy as np
import math
import json


if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

# change columns to lowercase
def column_lowercase(data: DataFrame) -> DataFrame:
    data.columns = data.columns = data.columns.str.replace(" ", "_").str.lower()
    return data

# # fill null_values and data restructuring
# def fill_null_values_restruct(data: DataFrame) -> DataFrame:
#     data = data.drop_duplicates().reset_index(drop=True)
#     data = data.reset_index(inplace=True)
#     data['travel_id'] = data['index']
#     data.drop(['index'], axis=1)
#     data['cancellation_code'] = data['cancellation_code'].fillna('E')
#     data[['carrier_day', 'nas_delay', 'weather_delay', 'security_delay', 'late_aircraft_delay']] =  data[['carrier_day', 'nas_delay', 'weather_delay', 'security_delay', 'late_aircraft_delay']].fillna(0)
  
#     return data

@transformer
def transform(data, *args, **kwargs):
    

    return column_lowercase(data)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
