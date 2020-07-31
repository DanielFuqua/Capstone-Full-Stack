import React from 'react';
import logo from './logo.svg';
import { BrowserRouter as Router } from "react-router-dom";
import { UserProfileProvider } from "./providers/UserProfileProvider";
import ApplicationViews from "./components/ApplicationViews";
import { PoseProvider } from './providers/PoseProvider';


function App() {
  return (
    <Router>
      <UserProfileProvider>
        <PoseProvider>
          <ApplicationViews />
        </PoseProvider>
      </UserProfileProvider>
    </Router>
  );
}

export default App;
