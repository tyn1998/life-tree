#ifndef __COMMON_H__
#define __COMMON_H__

#include "Snap.h"
#include <cstdlib>
#include <string>
#include <iostream>
#include <fstream>
#include <thread>

/* PUNGraph中的P代表这是个指针类型
 * UN代表是无向边
 * Graph代表是图, 即没有权重 */
typedef PUNGraph PGraph;

/* 输入的数据路径 */
static const std::string EXTRACTED_DATA_DIR = "input/treeoflife.interactomes";
static const std::string ORG_LOCATION = "input/organisms_list.txt";
/* static const std::string JOB_LIST_LOCATION = "job_list"; */

/* 输出的数据路径 */
static const std::string ROOT_DIR = "output";
static const std::string STAT_DIR = "statistics";
static const std::string KCORE_DIR = "kcores";
static const std::string DEGREE_DIR = "degrees";
static const std::string CURVE_DIR = "curvature";
static const std::string CLUSTER_DIR = "clustering";
static const std::string LORENZ_DIR = "lorenz";
static const std::string DEGREECTR_DIR = "degreecentrality";
static const std::string BETWEEN_DIR = "betweenness";
static const std::string CLOSE_DIR = "closeness";
static const std::string ADJACENCY_DIR = "adjacency";
static const std::string FRAGMENT_DIR = "fragmentation";
static const std::string ORCA_FILE_DIR = "orca-data";
static const std::string ORCA_STAT_DIR = "orca-statistics";
static const std::string ORCA_LOG_DIR = "orca-log";
/* graphlet调用的orca的路径 */
static const std::string ORCA_EXEC_LOCATION = "../bin/orca";

static const int MAX_LENGTH = 64;
static const int PRECISION = 8;
static const int NUM_ORG = 2020;
static const int CONCURRENCY = 200;
static const int REWIRE_Q = 100;

// Returns the file path containing the organism's data
std::string get_path(std::string dir, int organism) {
    // Use long long because gcc 4.4.7 doesn't support to_string(int)
    return dir + "/" + std::to_string((long long)organism);
}

// Returns the file path inside the root directory containing the organism's data
std::string get_path_rooted(std::string dir, int organism) {
    return ROOT_DIR + "/" + get_path(dir, organism);
}

// Makes a system call to create the desired directory
void make_dir(std::string dir) {
    system(("mkdir -p " + dir).c_str());
}

// Makes a system call to create the desired directory inside the root directory
void make_dir_rooted(std::string dir) {
    system(("mkdir -p " + ROOT_DIR + "/" + dir).c_str());
}

// Returns the output path given the directory and output type
std::string get_output_path(std::string dir, int organism, bool simple_output) {
    return simple_output ? dir : get_path_rooted(dir, organism);
}

#endif
