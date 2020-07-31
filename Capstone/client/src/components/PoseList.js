import React, { useContext, useEffect } from "react";
import { PoseContext } from "../providers/PoseProvider";
import Pose from "./Pose";

const PoseList = () => {

    const { poses, getAllPoses } = useContext(PoseContext);

    useEffect(() => {
        getAllPoses();
    }, []);
    
    console.log(poses)

    return (
        <div className="container">
            <div className="row justify-content-center">
                <div className="cards-column">
                    {poses.map((pose) => (
                        <Pose key={pose.id} pose={pose} />
                    ))}
                </div>
            </div>
        </div>
    );
};

export default PoseList;