import sys
import os


def getPred (indent_lev, name, *args):
  pred = "  "*indent_lev + f"({name}"
  for arg in args:
    pred += " " + arg
  return pred + ")\n"


def getBoardDims (board):
  dims = [len(l) for l in board.split("\n")]
  assert(len(set(dims)) == 1)
  return (len(dims), dims[0])

def getBoardItems (board):
  # types of items are (D drone) (P person) (S safe zone) (O obstacle)
  posChar = lambda s, c: tuple(i for i,ch in enumerate(s) if ch == c)
  serialized_board = board.replace("\n", "")
  return {"D": posChar(serialized_board, "D"),
          "P": posChar(serialized_board, "P"),
          "S": posChar(serialized_board, "S"),
          "O": posChar(serialized_board, "O"),}

def genAdjacencyRestrictions (bdims, indent_lev):
  restr = ""
  for i in range(bdims[0]*bdims[1]):
    # Vertical adjacency
    if i//bdims[1] != bdims[0]-1:
      restr += getPred(indent_lev, "adjacent", f"l{i+1}", f"l{i+bdims[1]+1}")
    # Horizontal adjacency
    if i%bdims[1] != bdims[1]-1:
      restr += getPred(indent_lev, "adjacent", f"l{i+1}", f"l{i+2}")
  return restr

def genElementRestr (belems, indent_lev):
  restr = ""
  if len(belems["D"]) != 1:
    raise Exception(f"wrong number of drones: {len(belems["D"])} != 1")
  if len(belems["S"]) != 1:
    raise Exception(f"wrong number of safe zones: {len(belems["S"])} != 1")
  restr += getPred(indent_lev, "drone-at", f"l{belems["D"][0]+1}")
  restr += getPred(indent_lev, "safe-zone", f"l{belems["S"][0]+1}")
  for obs in belems["O"]:
    restr += getPred(indent_lev, "obstacle", f"l{obs+1}")
  for pnum, ploc in enumerate(belems["P"]):
    restr += getPred(indent_lev, "person-at", f"p{pnum+1}", f"l{ploc+1}")
  return restr

def getObjects (belems, bdims, indent_lev):
  people = " ".join([f"p{i+1}" for i in range(len(belems["P"]))])
  locations = " ".join([f"l{i+1}" for i in range(bdims[0]*bdims[1])])
  return "  "*indent_lev + people +  " - person\n" + "  "*indent_lev + locations + " - location\n"

def getGoals (belems, indent_lev):
  return "".join([getPred(indent_lev, "rescued", f"p{i+1}") for i in range(len(belems["P"]))])



if len(sys.argv) != 4:
  raise Exception("this program expects input board path, safe zone capacity and t/f for verbose")
if sys.argv[3] not in ('t','f'):
  raise Exception("verbosity level not in (t,f)")
board_path = sys.argv[1]
safe_zone_capacity = int(sys.argv[2])
verbose = (sys.argv[3] == 't')
with open(sys.argv[1], "r") as f:
  board = f.read()

bdims = getBoardDims(board)
belems = getBoardItems(board)
objs = getObjects(belems, bdims, 2)
restr = genAdjacencyRestrictions(bdims, 2) + genElementRestr(belems, 2) +\
          f"    (= (safe-zone-capacity) {safe_zone_capacity})\n" + "    (= (safe-zone-occupancy) 0)\n"
goals = getGoals(belems, 2)

if verbose:
  print(f"Board ({bdims[0]}x{bdims[1]}):\n{board}\n")
  print(f"Elements: {belems}\n")
  print(f"Objects: {objs}\n")
  print(f"Restrictions:\n{restr}\n\n")

domain = fr"""(define (problem {os.path.basename(sys.argv[1]).split(".")[0]})
  (:domain rescue_drone)
  (:objects
{objs})
  (:init
{restr}  )
  (:goal (and
{goals}))
)"""

print(domain)