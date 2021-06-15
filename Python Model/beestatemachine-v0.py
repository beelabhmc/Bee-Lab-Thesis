#Model
import agentpy as ap

#Visualization
import matplotlib.pyplot as plt
import seaborn as sns
import IPython

print("\n \n")

class Bee(ap.Agent):
    """ A forager from the colony """
    
    def setup(self):  
        """ Initialize a new variable at agent creation """
        self.state = "inactive" 
        self.time_searching = 0 # Counter of how many ticks the bee was in the "searching" state
        self.time_foraging = 0 # Counter of how many ticks the bee was in the "foraging" state
        self.time_returning = 0 # Counter of how many ticks the bee was in the "returning" state
        # Possible states:
        #   "inactive": at the hive
        #   "searching": random foraging
        #   "foraging": found a resource
        #   "returning": en route back to the hive

    def be_inactive(self):
        """ What the inactive bees do that timestep """
        rg = self.model.random  # Random number generator

        if self.p.p_random_forage > rg.random():
            self.time_searching = 0 # Reset time searching counter
            self.state = "searching"

    def search(self):
        """ What the searching bees do that timestep """
        rg1 = self.model.random  # Random number generator
        rg2 = self.model.random  # Random number generator
        self.time_searching += 1 # add 1 tick to the time searching
        
        if self.p.p_find_food > rg1.random():
            self.time_foraging = 0 # Reset time foraging counter
            self.state = "foraging"
        elif self.p.p_abandon_search > rg2.random():
            self.time_returning = 0
            self.state = "returning"

    def forage(self):
        """ What the foraging bees do that timestep """
        self.time_foraging += 1
        if self.time_foraging >= 48:
            self.time_returning = 0
            self.state = "returning"

    def go_home(self):
        """ What the returning bees do that timestep """
        self.time_returning += 1
        if self.time_returning >= self.time_searching / 2:
            self.state = "inactive"


class ForagingModel(ap.Model):
    """ Agent-based model that simulates a very 
    simplified version of bee foraging behavior """

    def setup(self):
        """ Initialize the agents"""
        # Create agents and network
        self.add_agents(self.p.population, Bee)

    def update(self):  
        """ Record variables after setup and each step. """
        for s in ["inactive", "searching", "foraging", "returning"]:
            n_agents = len(self.agents.select(self.agents.state == s))
            self[s] = n_agents / self.p.population 
            self.record(s)

    def step(self):   
        """ Define the models' events per simulation step. """

        #Organize the bees into agentlists based on their states
        inactive_bees = self.agents.select(self.agents.state == "inactive")
        searching_bees = self.agents.select(self.agents.state == "searching")
        foraging_bees = self.agents.select(self.agents.state == "foraging")
        returning_bees = self.agents.select(self.agents.state == "returning")

        # Have the bees do things based on their states
        inactive_bees.be_inactive()
        searching_bees.search()
        foraging_bees.forage()
        returning_bees.go_home()

    def end(self):     
        """ Record evaluation measures at the end of the simulation. """
        # Record final evaluation measures
        self.measure('Max foragers', max(self.log['foraging']))

def foraging_stackplot(data, ax):
    """ Stackplot of people's condition over time. """
    x = data.index.get_level_values('t')
    y = [data[var] for var in ['inactive', 'searching', 'foraging', 'returning']]

    sns.set()  # Set seaborn theme for colors & lines
    ax.stackplot(x, y, 
                 labels=['Inactive', 'Searching', 'Foraging', 'Returning'],
                 colors = ['r', 'b', 'g', 'y'])    

    ax.legend()
    ax.set_xlim(0, max(1, len(x)-1))
    ax.set_ylim(0, 1)
    ax.set_xlabel("Time steps")
    ax.set_ylabel("Percentage of population")
    plt.show()

parameters = { 
    'population':5000, 
    'steps':200,
    'p_random_forage': 0.25,
    'p_abandon_search': 0.05,
    'p_find_food': 0.025
}

model = ForagingModel(parameters)
results = model.run() 

fig, ax = plt.subplots()
foraging_stackplot(results.variables, ax)

def interactive_plot(m):
    fig,ax = plt.subplots()
    foraging_stackplot(m.output.variables, ax)

param_ranges = {
    'population':(10,20), 
    'steps': 200,
    'p_random_forage': (0,0.5),
    'p_abandon_search': (0,1),
    'p_find_food': (0,1)
} 

sample = ap.sample_saltelli(param_ranges, n=5, digits=2)
exp = ap.Experiment(ForagingModel, sample)
exp.interactive(interactive_plot)
