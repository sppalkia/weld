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

import grizzly.numpy_weld as npw

def normalize_df(df):
    cols = {"origin", "dest", "carrier", "tailnum", "arr_delay"}
    for c in list(df.columns.values):
        if c not in cols:
            df.drop(c, 1)
    return df

def run(filename, use_grizzly=False, verbose=False, passes=None, threads=1, group=True, clo=True):
    flights_df = pd.read_csv(filename, dtype = {"origin": str, "dest": str, "tailnum": str, "arr_delay": np.float64})
    flights_df = normalize_df(flights_df)

    flights_df["arr_delay"] = flights_df["arr_delay"].fillna(0.0)

    if use_grizzly:
        flights_df = gr.DataFrameWeld(flights_df)

    start = time.time()

    start2 = 0
    end2 = 0

    # NYC Airports are JFK, EWR and LGA 
    # subsetting the flights from these airports to Seattle (SEA)
    sea_flights = flights_df[(flights_df['origin'] == 'JFK')]

    if use_grizzly:
        num_sea_flights = sea_flights.len()
    else:
        num_sea_flights = len(sea_flights)

    if use_grizzly and not clo:
        unique_carriers = sea_flights["carrier"]
        unique_planes = sea_flights["tailnum"]
        mean_delay = sea_flights["arr_delay"]
        unique_carriers, unique_planes, mean_delay, num_sea_flights = gr.group([unique_carriers, unique_planes, mean_delay, num_sea_flights]).evaluate(passes=passes, num_threads=threads)


        # TODO don't time this.
        start2 = time.time()
        unique_carriers = np.array(list(unique_carriers), dtype='str')
        unique_planes = np.array(list(unique_planes), dtype='str')
        end2 = time.time()

        # These are technically NumPy operators.
        unique_carriers = npw.unique(unique_carriers).evaluate(verbose=True, passes=passes, num_threads=threads)
        unique_planes = npw.unique(unique_planes).evaluate(verbose=True, passes=passes, num_threads=threads)
        mean_delay = npw.mean(mean_delay).evaluate(verbose=True, passes=passes, num_threads=threads)

    else:
        unique_carriers = sea_flights["carrier"].unique()
        unique_planes = sea_flights["tailnum"].unique()
        mean_delay = sea_flights["arr_delay"].mean()

        if use_grizzly:
            if group:
                unique_carriers, unique_planes, mean_delay, num_sea_flights = gr.group([unique_carriers, unique_planes, mean_delay, num_sea_flights]).evaluate(passes=passes, num_threads=threads)
            else:
                unique_carriers = unique_carriers.evaluate(passes=passes, num_threads=threads)
                unique_planes = unique_planes.evaluate(passes=passes, num_threads=threads)
                mean_delay = mean_delay.evaluate(passes=passes, num_threads=threads)
                num_sea_flights = num_sea_flights.evaluate(passes=passes, num_threads=threads)

    end = time.time()
    e2e_time = (end - start) - (end2 - start2)
    print "End-to-End:", e2e_time

    def into_readable_16(num):
        return chr(num & 0xff) + chr((num >> 8) & 0xff)

    if verbose:
        print "# NYC -> SEA flights:", num_sea_flights

        if use_grizzly and not clo:        
            print "Unique carriers:", [into_readable_16(int(x)) for x in list(unique_carriers)]
        else:
            print "Unique carriers:", unique_carriers

        print "Unique Planes:", unique_planes
        print "Mean Delay:", mean_delay

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Analyze Flight Delay data from NYC to SEA.")

    parser.add_argument('-f', '--filename', type=str, required=True)
    parser.add_argument('-g', '--grizzly', action='store_true')
    parser.add_argument('-v', '--verbose', action='store_true')
    parser.add_argument('-c', '--noclo', action='store_false')

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
            verbose=args.verbose,
            clo=args.noclo)

