#!/usr/bin/env python

"""
Various computations on flights from NYC to SEA.
Workload is adapted from https://github.com/akashjaswal/nyc-flights-analysis/blob/master/nyc%20code.py.
The data can be found at https://github.com/hadley/nycflights13.
"""

import time
import numpy as np

import pandas as pd
import grizzly.grizzly as gr

def normalize_df(df):
    cols = {"Origin", "Dest", "Carrier", "TailNum", "ArrDelay"}
    for c in list(df.columns.values):
        if c not in cols:
            df.drop(c, 1)
    return df

def run(filename, use_grizzly=False, verbose=False, passes=None, threads=1):
    flights_df = pd.read_csv(filename, dtype = {"Origin": str, "Dest": str, "TailNum": str, "ArrDelay": np.float32})
    flights_df = normalize_df(flights_df)

    if use_grizzly:
        flights_df = gr.DataFrameWeld(flights_df)

    start = time.time()

    # NYC Airports are JFK, EWR and LGA 
    # subsetting the flights from these airports to Seattle (SEA)
    sea_flights = flights_df[((flights_df['Origin'] == 'JFK') | (flights_df['Origin'] == 'EWR') 
                | (flights_df['Origin'] == 'LGA')) & (flights_df['Dest'] == 'SEA')]

    if use_grizzly:
        num_sea_flights = sea_flights.len()
    else:
        num_sea_flights = len(sea_flights)

    num_carriers = sea_flights["Carrier"].unique()
    # num_unique_planes = sea_flights["TailNum"].unique()
    # mean_delay = sea_flights["ArrDelay"].mean()

    if use_grizzly:
        #num_sea_flights, num_carriers, num_unique_planes = gr.group([num_sea_flights, num_carriers, num_unique_planes]).evaluate(passes=passes, num_threads=threads)
        # num_sea_flights = num_sea_flights.evaluate(passes=passes, num_threads=threads)
        print num_carriers
        num_carriers = num_carriers.evaluate(passes=passes, num_threads=threads)
        # num_unique_planes = num_unique_planes.evaluate(passes=passes, num_threads=threads)

    end = time.time()

    e2e_time = end - start
    print "End-to-End:", e2e_time

    if verbose:
        # print "NYC -> SEA flights:", num_sea_flights
        print "Carriers:", len(num_carriers)
        # print "Unique Planes:", num_unique_planes
        # print "Mean Delay:", mean_delay

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Analyze Flight Delay data from NYC to SEA.")

    parser.add_argument('-f', '--filename', type=str, required=True)
    parser.add_argument('-g', '--grizzly', action='store_true')
    parser.add_argument('-v', '--verbose', action='store_true')

    # For weld-benchmarks
    parser.add_argument('-p', '--passes', nargs='+', type=str, default=None)
    parser.add_argument('-s', '--scale', type=int, default=1)
    parser.add_argument('-t', '--threads', type=int, default=1)

    args = parser.parse_args()

    passes = None
    if args.passes is not None:
        passes = [p.strip().lower() for p in args.passes]
    if args.passes == [""]:
       	passes = None

    try:
        filename = args.filename % args.scale
    except:
        filename = args.filename

    run(filename,
            use_grizzly=args.grizzly,
            passes=passes,
            threads=str(args.threads),
            verbose=args.verbose)

