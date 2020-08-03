import React from "react";
import { useParams } from "react-router-dom";
import Comments from "./Comments";
import PoseDetails from "./PoseDetails";
import Notes from "./Notes";
import "./PostureView.css";

const PostureView = () => {

    return (
        <section className="posture_container">
            <Notes />
            <PoseDetails />
            <Comments />
        </section>

    );
};
export default PostureView;