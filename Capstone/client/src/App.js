import React from 'react';
import logo from './logo.svg';
import { BrowserRouter as Router } from "react-router-dom";
import { UserProfileProvider } from "./providers/UserProfileProvider";
import ApplicationViews from "./components/ApplicationViews";
import { PoseProvider } from './providers/PoseProvider';
import { InstructionProvider } from './providers/InstructionProvider';


function App() {
  return (
    <Router>
      <UserProfileProvider>
        <PoseProvider>
          <InstructionProvider>
            <ApplicationViews />
          </InstructionProvider>
        </PoseProvider>
      </UserProfileProvider>
    </Router>
  );
}

export default App;
