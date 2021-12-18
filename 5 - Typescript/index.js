"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs = __importStar(require("fs"));
class Coord {
    constructor(x1, y1, x2, y2) {
        this.startX = parseInt(x1);
        this.startY = parseInt(y1);
        this.endX = parseInt(x2);
        this.endY = parseInt(y2);
    }
}
function main() {
    let data = readFile();
    part1(data);
    part2(data);
}
function readFile() {
    let data = new Array;
    let a = fs.readFileSync("input.txt", "utf8");
    let arr = a.split("\n");
    arr.forEach(i => {
        let f = (i.split("->").at(0));
        let s = (i.split("->").at(1));
        if (f && s) {
            let x1 = f.split(",").at(0);
            let y1 = f.split(",").at(1);
            let x2 = s.split(",").at(0);
            let y2 = s.split(",").at(1);
            if (x1 && x2 && y1 && y2)
                data.push(new Coord(x1, y1, x2, y2));
        }
    });
    return data;
}
function updateRow(coords, map) {
    if (coords.startY != coords.endY)
        return map;
    var x = coords.startX;
    var x1 = coords.endX;
    if (x1 < x) {
        var temp = x;
        x = x1;
        x1 = temp;
    }
    // console.log(coords, " :", x, x1)
    for (var i = x; i <= x1; i++) {
        map[coords.startY][i] += 1;
    }
    return map;
}
function updateColumn(coords, map) {
    if (coords.startX != coords.endX)
        return map;
    var y = coords.startY;
    var y1 = coords.endY;
    if (y1 < y) {
        var temp = y;
        y = y1;
        y1 = temp;
    }
    for (var i = y; i <= y1; i++) {
        map[i][coords.startX] += 1;
    }
    return map;
}
function updateDiagonal(coords, map) {
    if (coords.startX != coords.endX)
        if (coords.startY != coords.endY) {
            var y = coords.startY;
            var y1 = coords.endY;
            var x = coords.startX;
            var x1 = coords.endX;
            var func1;
            var func2;
            var reversed = false;
            if (y > y1)
                func1 = function (i) { return i -= 1; };
            else
                func1 = function (i) { return i += 1; };
            if (x > x1) {
                func2 = function (i) { return i -= 1; };
                reversed = true;
            }
            else
                func2 = function (i) { return i += 1; };
            console.log("\n");
            // console.log(func1(1))
            var i, j;
            if (reversed)
                for (i = x, j = y; i >= x1; j = func1(j), i = func2(i)) {
                    // console.log(i, j)
                    map[j][i] += 1;
                }
            else
                for (i = x, j = y; i <= x1; j = func1(j), i = func2(i)) {
                    // console.log(i, j)
                    map[j][i] += 1;
                }
        }
    return map;
}
function part1(data) {
    var map = [];
    for (var i = 0; i < 10000; i++) {
        map.push([]);
        for (var j = 0; j < 10000; j++) {
            map[i].push(0);
        }
    }
    data.forEach(i => {
        map = updateColumn(i, map);
        map = updateRow(i, map);
    });
    var crosses = 0;
    for (let i = 0; i < map.length; i++) {
        for (let j = 0; j < map[i].length; j++) {
            if (map[i][j] >= 2) {
                crosses += 1;
            }
        }
    }
    console.log(crosses);
}
function part2(data) {
    var map = [];
    for (var i = 0; i < 10000; i++) {
        map.push([]);
        for (var j = 0; j < 10000; j++) {
            map[i].push(0);
        }
    }
    data.forEach(i => {
        map = updateColumn(i, map);
        map = updateRow(i, map);
        map = updateDiagonal(i, map);
    });
    // map.forEach(em => {
    //     console.log(em.join(' '))
    // });
    var crosses = 0;
    for (let i = 0; i < map.length; i++) {
        for (let j = 0; j < map[i].length; j++) {
            if (map[i][j] >= 2) {
                crosses += 1;
            }
        }
    }
    console.log(crosses);
}
main();
