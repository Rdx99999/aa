import subprocess

def run_command():
    try:
        # Define the command to execute
        command = "curl -sSf https://sshx.io/get | sh -s run"
        
        # Execute the command
        result = subprocess.run(command, shell=True, check=True, text=True, capture_output=True)
        
        # Print the command output
        print("Command Output:\n", result.stdout)
        
    except subprocess.CalledProcessError as e:
        print("An error occurred while running the command:")
        print(e.stderr)

if __name__ == "__main__":
    run_command()
